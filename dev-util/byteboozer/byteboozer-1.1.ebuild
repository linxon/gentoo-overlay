# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="c64 data compression software"
HOMEPAGE="http://csdb.dk/release/?id=109317"
LICENSE="GPL-2"

MY_PN="bb"
SRC_URI="http://csdb.dk/getinternalfile.php/106578/${MY_PN}.7z"

RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"
SLOT="0"
S="${WORKDIR}"/${MY_PN}

src_install() {
	exeinto /usr/share/${PN}/
	doexe bb

	dosym ../share/${PN}/${MY_PN} /usr/bin/${PN}
}
