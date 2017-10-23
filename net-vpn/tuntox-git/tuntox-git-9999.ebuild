# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
MY_PN="${PN%%-git}"

inherit eutils git-r3 user systemd

DESCRIPTION="Tunnel TCP connections over the Tox protocol"
HOMEPAGE="https://github.com/gjedeer/tuntox https://rocketgit.com/user/gdr/tuntox"
SRC_URI=""

EGIT_REPO_URI="https://github.com/gjedeer/tuntox"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE="systemd static"

DOCS=( README.md VPN.md BUILD.md )

RDEPEND="
	dev-libs/libevent[threads]
	dev-libs/libsodium
	sys-libs/glibc:2.2
	net-libs/tox"

DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup ${MY_PN}
	enewuser ${MY_PN} -1 -1 /var/lib/${MY_PN} ${MY_PN}
}

src_prepare() {
	# Do not rename binary files
	sed -i \
		-e "s/\$(CC) -o \$@/\$(CC) -o ${MY_PN}/" Makefile || die "sed failed!"

	use systemd && ( 
		sed -i \
			-e "s/#User=proxy/User=${MY_PN}/" \
			-e "s/#Group=proxy/Group=${MY_PN}/" scripts/tuntox.service || die "sed failed!" 
	)

	epatch "${FILESDIR}"/${P}_update_env.diff
	eapply_user
}

src_compile() {
	local make_opts=( 
		tox_bootstrap.h \
		gitversion.h \
		$(use static \
			&& echo tuntox \
			|| echo tuntox_nostatic)
	)

	emake ${make_opts[@]}
}

src_install() {
	local _dir
	local req_var_dirs="lib log"

	for _dir in ${req_var_dirs}; do
		keepdir "/var/${_dir}/${MY_PN}"
		fowners ${MY_PN}:${MY_PN} "/var/${_dir}/${MY_PN}"
		fperms 740 "/var/${_dir}/${MY_PN}"
	done

	insinto /var/lib/${MY_PN}
	doins "${FILESDIR}"/tuntox.conf
	fowners ${MY_PN}:${MY_PN} "/var/lib/${MY_PN}"/tuntox.conf

	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/tuntox.logrotated ${MY_PN}

	newinitd "${FILESDIR}"/tuntox.initd ${MY_PN}
	newconfd "${FILESDIR}"/tuntox.confd ${MY_PN}
	use systemd && systemd_dounit scripts/tuntox.service

	dobin ${MY_PN}
	dobin scripts/tokssh
}

pkg_postinst() {
	ewarn
	ewarn "Please, add yourself to the \"${MY_PN}\" group. This security measure ensures"
	ewarn "that only trusted users can use tuntox."
	ewarn
	elog "See documentation: https://github.com/gjedeer/tuntox#introduction"
}
