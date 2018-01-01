# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

MY_P="Markdown_${PV}"
DESCRIPTION="Markdown Viewer"
HOMEPAGE="https://daringfireball.net/"
SRC_URI="http://daringfireball.net/projects/downloads/${MY_P}.zip"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"
IUSE="+autoconv"
S="${WORKDIR}"/"${MY_P}"

DEPEND=""
RDEPEND="${DEPEND}
	autoconv? ( >=app-text/html2text-1.3.2a )
	dev-lang/perl"

src_install() {
	local scr_name="${MY_P%%_${PV}}.pl"

	dobin ${scr_name}
	if use autoconv; then
		dobin "${FILESDIR}"/${PN}
	else
		dosym ./${scr_name} /usr/bin/${PN} || die
	fi
}
