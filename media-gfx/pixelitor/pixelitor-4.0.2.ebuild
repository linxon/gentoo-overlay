# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit xdg-utils gnome2-utils

DESCRIPTION="Pixelitor is a free and open source image editing software"
HOMEPAGE="http://pixelitor.sourceforge.net/"
LICENSE="GPL-3"

MY_P="${PN}_${PV}"
SRC_URI="https://netcologne.dl.sourceforge.net/project/pixelitor/${PV}/${MY_P}.jar"

KEYWORDS="~amd64 ~x86"
SLOT="0"

S="${WORKDIR}"

DEPEND=""
RDEPEND="${DEPEND}
	dev-java/oracle-jdk-bin:1.8"

src_unpack() {
	unpack ${A} && cp "${DISTDIR}"/"${MY_P}.jar" "${WORKDIR}" || die
	unpack "${FILESDIR}"/${PN}.png.tar.gz
}

src_install() {
	local inst_dir="/opt/${P}"
	local ex_file="${PN}.jar"

	mv ${MY_P}.jar ${ex_file} || die
	mv Readme_licenses.txt README || die

	insinto "${inst_dir}"
	doins ${ex_file}

	insinto /usr/share/pixmaps/
	doins "${WORKDIR}"/${PN}.png

	make_wrapper "${PN}" "/usr/bin/java -jar \"${inst_dir}/${ex_file}\""
	make_desktop_entry "/usr/bin/${PN}" "Pixelitor" "${PN}" "Graphics" "Path=${inst_dir}"

	dodoc README
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
