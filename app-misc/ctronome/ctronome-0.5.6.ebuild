# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A simple metronome for the commandline"
HOMEPAGE="http://ctronome.kign.org/"
LICENSE="GPL-2"

SRC_URI="http://ctronome.kign.org/source/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/${PN}
	doins -r *.wav

	dobin ${PN}
	dodoc ChangeLog COPYING NOTES README TODO prog_example.txt
}