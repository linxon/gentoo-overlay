# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils xdg-utils

MY_P="${P}-2016-11-21"

DESCRIPTION="Free open source DAW, MIDI sequencer, software synthesizers"
HOMEPAGE="http://www.frinika.com"
SRC_URI="https://kent.dl.sourceforge.net/project/frinika/frinika/${P}/${MY_P}.zip"
KEYWORDS="amd64 x86"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}"/${MY_P}

DEPEND=""
RDEPEND="${DEPEND}
	dev-java/oracle-jdk-bin:1.8"

src_unpack() {
	unpack "${A}"
	unpack "${FILESDIR}"/${PN}.png.tar.gz
}

src_install() {
	local inst_dir="/opt/${P}"
	local ex_file="${PN}.jar"

	insinto "${inst_dir}"
	doins ${ex_file}
	doins -r lib

	insinto /usr/share/pixmaps/
	doins ${WORKDIR}/${PN}.png

	make_wrapper "${PN}" "/usr/bin/java -jar \"${inst_dir}/${ex_file}\""
	make_desktop_entry "/usr/bin/${PN}" "Frinika" "${PN}" "AudioVideo;Audio" "Path=${inst_dir}"

	dodoc LICENSE.md README.TXT
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
