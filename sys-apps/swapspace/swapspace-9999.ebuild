# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-info systemd

DESCRIPTION="A fork of Jeroen T. Vermeulen's excellent dynamic swap space manager"
HOMEPAGE="https://github.com/Tookmund/Swapspace"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Tookmund/Swapspace"
else
	SRC_URI="https://github.com/Tookmund/Swapspace/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~x86"

	S="${WORKDIR}/Swapspace-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="sys-apps/util-linux"
RDEPEND="${DEPEND}"

pkg_setup() {
	local CONFIG_CHECK="~SWAP"
	local WARNING_SWAP="CONFIG_SWAP is required for ${PN} support."

	check_extra_config
}

src_prepare() {
	default
	eautoreconf
}

src_install() {
	dosbin src/swapspace

	keepdir "/var/lib/${PN}"
	fperms 0700 "/var/lib/${PN}"

	newconfd "${FILESDIR}"/swapspace.confd $PN
	newinitd "${FILESDIR}"/swapspace.initd-r2 $PN
	systemd_dounit "${FILESDIR}"/swapspace.service

	insinto "/etc"
	doins "${FILESDIR}"/swapspace.conf

	doman doc/*.8
	dodoc README.md NEWS INSTALL ChangeLog \
		AUTHORS swapspace.conf
}

pkg_postinst() {
	einfo "\nTo run Swapspace as background service use:"
	einfo "OpenRC:"
	einfo "    ~# rc-service swapspace start"
	einfo "    ~# rc-update add swapspace boot"
	einfo "Systemd:"
	einfo "    ~# systemctl start swapspace.service"
	einfo "    ~# systemctl enable swapspace.service\n"
	einfo "Please see README at /usr/share/doc/${PF}/README.md.bz2 for"
	einfo "further information about the Swapspace\n"
}
