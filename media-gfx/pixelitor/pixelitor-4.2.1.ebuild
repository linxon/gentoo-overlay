# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils xdg-utils

DESCRIPTION="Pixelitor is a free and open source image editing software"
HOMEPAGE="http://pixelitor.sourceforge.net/"

MY_P="Pixelitor-${PV}"
SRC_URI="https://github.com/lbalazscs/Pixelitor/releases/download/v${PV}/${MY_P}.jar"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	|| ( virtual/jre virtual/jdk )"

S="${WORKDIR}"

src_unpack() {
	unpack ${A} && cp "${DISTDIR}/${MY_P}.jar" "${WORKDIR}" || die
	unpack "${FILESDIR}"/${PN}.png.tar.gz
}

src_install() {
	local inst_dir="/opt/${P}"
	local ex_file="${PN}.jar"

	mv ${MY_P}.jar ${ex_file} || die

	insinto "$inst_dir"
	doins $ex_file

	insinto "/usr/share/pixmaps/"
	doins "${WORKDIR}"/${PN}.png

	make_wrapper "$PN" "/usr/bin/java -jar \"${inst_dir}/${ex_file}\""
	make_desktop_entry $PN \
		"Pixelitor" \
		"${PN}" \
		"Graphics" \
		"Path=${inst_dir}"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
