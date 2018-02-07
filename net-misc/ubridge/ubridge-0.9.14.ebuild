# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils user

DESCRIPTION="Bridge for UDP tunnels, Ethernet, TAP and VMnet interfaces."
HOMEPAGE="https://github.com/GNS3/ubridge"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GNS3/ubridge"
else
	SRC_URI="https://github.com/GNS3/ubridge/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE="+suid"

RDEPEND="
	net-libs/libpcap
	sys-libs/glibc"

DEPEND="${RDEPEND}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_compile() {
	emake
}

src_install() {
	dobin ${PN}
	if use suid; then
		fowners root:${PN} /usr/bin/${PN}
		fperms 4750 /usr/bin/${PN}
	fi

	dodoc README.rst 
}

pkg_postinst() {
	if use suid; then
		ewarn
		ewarn "Just run 'gpasswd -a <USER> ${PN}' then have <USER> re-login."
		ewarn
	fi
}
