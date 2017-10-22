# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Small program for Linux that will turn your Scroll, Caps or Num Lock LED into hard disk indicator"
HOMEPAGE="https://github.com/MeanEYE/Disk-Indicator"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MeanEYE/Disk-Indicator"
else
	MY_P="Disk-Indicator-${PV}"
	SRC_URI="https://github.com/MeanEYE/Disk-Indicator/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}"/${MY_P}
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

src_install() {
	dodoc DEPENDS AUTHORS README.md "${FILESDIR}"/config.sample
	dobin disk_indicator
}

pkg_postinst() {
	elog
	elog "Usage:"
	elog "  ~$ cp /usr/share/doc/${P}/config.sample* ~/.disk_indicator"
	elog "  ~$ disk_indicator -c ~/.disk_indicator"
	elog
}
