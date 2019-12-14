# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils xdg-utils

DESCRIPTION="Pixelitor is a free and open source image editing software"
HOMEPAGE="http://pixelitor.sourceforge.net/"

MY_P="Pixelitor-${PV}"
SRC_URI="https://github.com/lbalazscs/Pixelitor/releases/download/v${PV}/${MY_P}.jar"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="|| ( virtual/jre virtual/jdk )"

S="${WORKDIR}"

src_install() {
	local inst_dir="/opt/${P}"
	local ex_file="${PN}.jar"

	insinto "$inst_dir"
	newins "${DISTDIR}/${MY_P}.jar" $ex_file

	for s in 32 48 256; do
		newicon -s ${s} images/pixelitor_icon${s}.png pixelitor_icon.png
	done

	make_wrapper $PN "/usr/bin/java -jar \"${inst_dir}/${ex_file}\""
	make_desktop_entry $PN \
		"Pixelitor" \
		"pixelitor_icon" \
		"Graphics"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
