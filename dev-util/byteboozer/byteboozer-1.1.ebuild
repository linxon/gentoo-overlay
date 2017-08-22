# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

MY_PN="bb"
DESCRIPTION="c64 data compression software"
HOMEPAGE="http://csdb.dk/release/?id=109317"
SRC_URI="http://csdb.dk/getinternalfile.php/106578/bb.7z"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}"/${MY_PN}

src_install() {
	exeinto /usr/share/${PN}/
	doexe bb

	dosym /usr/share/${PN}/${MY_PN} /usr/bin/${PN}
}