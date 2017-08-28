# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="A advanced launcher for Minecraft"
HOMEPAGE="https://tlauncher.org"
SRC_URI="https://tlauncher.org/download/3049 -> ${P}.jar"
KEYWORDS="~amd64 ~x86"
LICENSE="all-rights-reserved"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	dev-java/oracle-jdk-bin
"

src_unpack() {
	mkdir "${WORKDIR}"/"${P}" || die
	cp "${DISTDIR}"/"${P}.jar" "${WORKDIR}"/"${P}"/"${P}.jar" || die
	tar -x -f "${FILESDIR}"/icon.tar.gz -C "${WORKDIR}"/"${P}" || die
}

src_install() {
	local inst_dir="/opt/${P}"
	local ex_file="${PN}.jar"

	insinto "${inst_dir}"
	newins "${DISTDIR}"/"${P}.jar" "${ex_file}"

	insinto /usr/share/pixmaps/
	newins minecraft.png ${PN}.png

	make_wrapper "${PN}" "/usr/bin/java -jar \"${inst_dir}/${ex_file}\""
	make_desktop_entry "/usr/bin/${PN}" "TLauncher ${PV}" "${PN}" "Game" "StartupNotify=false"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
