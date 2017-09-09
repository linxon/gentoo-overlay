# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="A advanced launcher for Minecraft"
HOMEPAGE="https://tlauncher.org"
LICENSE="all-rights-reserved"

SRC_URI="http://tlauncherrepo.com/legacy/bootstrap/00aa8d0014ce30f2116a13b8313de65cc9be690f475758d83359e7756fa848f0.jar -> ${P}.jar"

RESTRICT="mirror"
KEYWORDS="amd64 x86"
SLOT="1"

DEPEND=""
RDEPEND="${DEPEND}
	dev-java/oracle-jdk-bin"

src_unpack() {
	local w_path="${WORKDIR}"/"${P}"

	mkdir "${w_path}" || die
	cp "${DISTDIR}"/"${P}.jar" "${w_path}"/"${P}.jar" || die
	tar -x -f "${FILESDIR}"/icon.tar.gz -C "${w_path}" || die
}

src_install() {
	local inst_dir="/opt/${P}"
	local ex_file="${PN}.jar"

	insinto "${inst_dir}"
	newins "${DISTDIR}"/"${P}.jar" "${ex_file}"
	insinto /usr/share/pixmaps/
	newins minecraft.png ${PN}-${SLOT}.png

	make_wrapper "${PN}${SLOT}" "/usr/bin/java -jar \"${inst_dir}/${ex_file}\""
	make_desktop_entry "/usr/bin/${PN}${SLOT}" "TLauncher ${PV}" "${PN}-${SLOT}" "Game" "StartupNotify=false"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
