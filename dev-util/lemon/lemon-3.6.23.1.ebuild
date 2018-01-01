# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs eutils

DESCRIPTION="A LALR(1) parser generator."
HOMEPAGE="http://www.hwaci.com/sw/lemon/"
LICENSE="public-domain"

SRC_URI="http://www.sqlite.org/sqlite-${PV}.tar.gz"

KEYWORDS="~x86 ~amd64"
SLOT="0"

S="${WORKDIR}"/sqlite-${PV}

src_prepare() {
	cd "${S}"/tool/
	epatch "${FILESDIR}"/lemon.patch
	eapply_user
}

src_compile() {
	cd "${S}"/tool/
	"$(tc-getCC)" -o lemon lemon.c || die
}

src_install() {
	cd "${S}"/tool/
	dodir /usr/share/lemon/
	insinto /usr/share/lemon/
	doins lempar.c
	dobin lemon
}
