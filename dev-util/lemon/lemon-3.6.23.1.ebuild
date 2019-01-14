# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs

DESCRIPTION="A LALR(1) parser generator."
HOMEPAGE="http://www.hwaci.com/sw/lemon/"
SRC_URI="http://www.sqlite.org/sqlite-${PV}.tar.gz"
LICENSE="public-domain"
KEYWORDS="amd64 x86"
SLOT="0"

S="${WORKDIR}"/sqlite-${PV}/tool

src_prepare() {
	epatch "${FILESDIR}"/lemon.patch
	eapply_user
}

src_compile() {
	"$(tc-getCC)" -o lemon lemon.c || die 'failed to install!'
}

src_install() {
	insinto /usr/share/lemon/
	doins lempar.c
	dobin lemon
}
