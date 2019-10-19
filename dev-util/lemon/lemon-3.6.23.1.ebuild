# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A LALR(1) parser generator"
HOMEPAGE="https://www.hwaci.com/sw/lemon/"
SRC_URI="https://www.sqlite.org/sqlite-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

PATCHES=( "${FILESDIR}/${P}_gentoo.patch" )

S="${WORKDIR}/sqlite-${PV}/tool"

src_compile() {
	"$(tc-getCC)" -Wall -o lemon lemon.c || die
}

src_install() {
	insinto "/usr/share/lemon/"
	doins lempar.c
	dobin lemon
}
