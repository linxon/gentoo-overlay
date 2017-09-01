# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="Electronic circuit simulator written in Java by falstad.com"
HOMEPAGE="http://www.falstad.com/circuit-java/"
SRC_URI="http://www.falstad.com/circuit-java/${PN}.zip -> ${P}.zip"
KEYWORDS="amd64 x86"
LICENSE="GPL"
S="${WORKDIR}"
SLOT="0"
IUSE="+examples source"
DEPEND=""
RDEPEND="${DEPEND}
	dev-java/oracle-jdk-bin
"

src_unpack() {
	unpack "${A}"
	unpack "${FILESDIR}"/circuit.png.tar.gz
}

src_install() {
	local inst_dir="/opt/${P}"
	local ex_file="${PN}.jar"

	insinto "${inst_dir}"
	doins ${ex_file}
	doins setuplist.txt
	use source && doins src.zip
	use examples && doins -r circuits

	insinto /usr/share/pixmaps/
	doins ${PN}.png

	make_wrapper "${PN}" "/usr/bin/java -jar \"${inst_dir}/${ex_file}\""
	make_desktop_entry "/usr/bin/${PN}" "Circuit simulator ${PV}" "${PN}" "Education" "StartupNotify=false"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	if use examples; then
		ewarn
		ewarn "You can find examples on: /opt/${P}/circuits/*"
		ewarn "See documentation: ${HOMEPAGE}e-index.html"
		ewarn
	fi

	xdg_desktop_database_update
	gnome2_icon_cache_update
}
