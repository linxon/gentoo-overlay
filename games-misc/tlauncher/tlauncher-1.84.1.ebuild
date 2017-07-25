# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="A advanced launcher for Minecraft"
HOMEPAGE="https://tlauncher.org"
SRC_URI="http://tlauncherrepo.com/legacy/bootstrap/04c4d5d12fdfb3a9e4b0c4623f756b92613abbb8c6d4eff701c963ab73df9cd4.jar -> ${P}.jar"
KEYWORDS="amd64 x86"
LICENSE="MIT"
SLOT="0"

DEPEND="dev-java/oracle-jdk-bin"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir "${WORKDIR}"/"${P}" || die
	cp "${DISTDIR}"/"${P}.jar" "${WORKDIR}"/"${P}"/"${P}.jar" || die

	return
}

src_install() {
	local inst_dir="/opt/${PN}"

	insinto "${inst_dir}"
	newins "${DISTDIR}"/"${P}.jar" "${PN}.jar"

	insinto /usr/share/pixmaps/
	newins "${FILESDIR}"/minecraft.png ${PN}.png

	dobin "${FILESDIR}"/tlauncher

	make_desktop_entry "/usr/bin/${PN}" "TLauncher" "${PN}" "Game" "StartupNotify=false"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
