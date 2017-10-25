# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
MY_PN="${PN%%-bin}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Colorizing \"cat\""
HOMEPAGE="https://github.com/jingweno/ccat"

SRC_URI="
	amd64? ( https://github.com/jingweno/ccat/releases/download/v${PV}/linux-amd64-${PV}.tar.gz -> ${MY_P}.tar.gz )
	x86? ( https://github.com/jingweno/ccat/releases/download/v${PV}/linux-386-${PV}.tar.gz -> ${MY_P}.tar.gz )"

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	default
	mv "${WORKDIR}"/linux-* ${P}
}

src_install() {
	dobin ${MY_PN}
	dodoc README.md
}

pkg_postinst() {
	elog
	elog "It's recommended to alias ccat to cat:"
	elog "alias cat=ccat"
	elog
	elog "See documentation: https://github.com/jingweno/ccat#usage"
	elog
}
