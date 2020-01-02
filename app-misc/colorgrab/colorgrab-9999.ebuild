# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

BUILD_DIR="${S}"
WX_GTK_VER="3.0"

inherit desktop cmake wxwidgets xdg-utils

DESCRIPTION="A cross-platform color picker"
HOMEPAGE="https://github.com/nielssp/colorgrab"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nielssp/colorgrab"
else
	SRC_URI="https://github.com/nielssp/colorgrab/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="x11-libs/wxGTK:${WX_GTK_VER}[X]"
DEPEND="${RDEPEND}"

pkg_setup() {
	setup-wxwidgets
}

src_install() {
	newicon -s scalable img/scalable.svg ${PN}.svg
	for s in 16 32 48 64 128 256; do
		newicon -s ${s} img/${s}x${s}.png ${PN}.png
	done

	dobin $PN
	dodoc README.md

	make_desktop_entry $PN \
		"ColorGrab" $PN \
		"Utility;Graphics"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
