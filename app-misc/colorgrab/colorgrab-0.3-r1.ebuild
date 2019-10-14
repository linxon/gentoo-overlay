# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

BUILD_DIR="${S}"

inherit desktop eutils cmake-utils gnome2-utils wxwidgets xdg-utils

DESCRIPTION="A cross-platform color picker"
HOMEPAGE="https://github.com/nielssp/colorgrab"
LICENSE="MIT"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nielssp/colorgrab"
else
	SRC_URI="https://github.com/nielssp/colorgrab/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

SLOT="0"
IUSE=""

RDEPEND="x11-libs/wxGTK:3.0"
DEPEND="${RDEPEND}"

src_install() {
	local size

	insinto "/usr/share/icons/hicolor/scalable/apps/"
	newins "img/scalable.svg" "${PN}.svg"

	for size in 16 32 48 64 128 256; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps/"
		newins "img/${size}x${size}.png" "${PN}.png"
	done

	dobin $PN
	dodoc README.md

	make_desktop_entry $PN \
		"ColorGrab" $PN \
		"Utility;Graphics"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
