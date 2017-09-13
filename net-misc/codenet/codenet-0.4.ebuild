# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="The Final Replay comes with a network server dedicated to cross assembling and remote program execution"
HOMEPAGE="http://www.oxyron.de/html/codenet.html"
LICENSE="GPL-2"

SRC_URI="http://www.oxyron.de/storage/codenet04src.zip -> ${P}.zip"

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
SLOT="0"

S="${WORKDIR}"

src_install() {
	dobin ${PN}
}

pkg_postinst() {
	elog
	elog "Protocol documentation: http://www.oxyron.de/html/codenet_protocol.html"
	elog
}
