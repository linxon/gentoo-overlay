# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit xdg-utils gnome2-utils

DESCRIPTION="The GalleryGrabber is a tool for people who use online galleries a lot. It searches through galleries and gets the newest pics. Currently supported galleries are: deviantArt, FChan, Furaffinity, VCL, Yiffstar"
HOMEPAGE="http://gallerygrabber.sourceforge.net/"
LICENSE="GPL-2"

MY_PN="GalleryGrabber"
MY_P="${MY_PN}${PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

KEYWORDS="amd64 x86"
RESTRICT="mirror"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	dev-java/oracle-jdk-bin:1.8"

S="${WORKDIR}"/${MY_PN}

src_unpack() {
	unpack ${A}
	unpack "${FILESDIR}"/icon.png.tar.gz
	mv "${WORKDIR}"/${MY_PN}* "${WORKDIR}"/${MY_PN} || die
}

src_install() {
	local inst_dir="/opt/${P}"
	local ex_file="${MY_PN}.jar"

	insinto "${inst_dir}"
	doins ${ex_file}
	doins -r Workfiles

	insinto /usr/share/pixmaps/
	doins "${WORKDIR}"/icon.png

	make_wrapper "${PN}" "/usr/bin/java -jar \"${inst_dir}/${ex_file}\""
	make_desktop_entry "/usr/bin/${PN}" "${MY_PN}" "${PN}" "Graphics;Network;" "Path=${inst_dir}"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
