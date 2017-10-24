# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
DAEMON_NAME="${PN}d"

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

RDEPEND="
	dev-libs/libevent[threads]
	>=dev-libs/libsodium-0.5.0
	net-libs/tox
	sys-libs/glibc:2.2"

DEPEND="${RDEPEND}
	dev-python/jinja
	dev-python/requests"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
}

src_prepare() {
	# Do not rename binary files
	sed -i \
		-e "s/\$(CC) -o \$@/\$(CC) -o ${DAEMON_NAME}/" Makefile || die "sed failed!"

	use systemd && (
		sed -i \
			-e "s/#User=proxy/User=${PN}/" \
			-e "s/#Group=proxy/Group=${PN}/" scripts/tuntox.service || die "sed failed!"
	)

	eapply "${FILESDIR}"
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
		keepdir "/var/${_dir}/${PN}"
		fowners ${PN}:${PN} "/var/${_dir}/${PN}"
		fperms 740 "/var/${_dir}/${PN}"
	done

	insinto /var/lib/${PN}
	doins "${FILESDIR}"/tuntox.conf "${FILESDIR}"/rules.example
	fowners ${PN}:${PN} "/var/lib/${PN}"/{tuntox.conf,rules.example}

	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/tuntox.logrotated ${PN}

	newinitd "${FILESDIR}"/tuntox.initd ${DAEMON_NAME}
	newconfd "${FILESDIR}"/tuntox.confd ${DAEMON_NAME}
	use systemd && systemd_dounit scripts/tuntox.service

	dosbin ${DAEMON_NAME} && dosym /usr/sbin/${DAEMON_NAME} /usr/bin/${PN}
	dobin scripts/tokssh

	dodoc README.md VPN.md BUILD.md
}

pkg_postinst() {
	ewarn
	ewarn "Please, add yourself to the \"${PN}\" group. This security measure ensures"
	ewarn "that only trusted users can use tuntox."
	ewarn
	elog "See documentation: https://github.com/gjedeer/tuntox#introduction"
}
