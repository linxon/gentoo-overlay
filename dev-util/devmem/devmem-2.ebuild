# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs eutils

DESCRIPTION="A small utility to access /dev/mem and read/write to any memory location"
HOMEPAGE="http://free-electrons.com/pub/mirror/"
LICENSE="GPL-2"
SRC_URI="http://free-electrons.com/pub/mirror/devmem2.c -> ${P}.c"
RESTRICT="mirror"
KEYWORDS="~amd64 ~arm ~mips ~x86"
SLOT="0"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}"/${P}.c "${WORKDIR}" || die
}

src_compile() {
	"$(tc-getCC)" -o ${PN} ${P}.c || die
}

src_install() {
	dobin ${PN}
}
