# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit git-r3 eutils cmake-utils gnome2-utils xdg-utils

DESCRIPTION="A cross-platform color picker"
HOMEPAGE="https://github.com/nielssp/colorgrab"
EGIT_REPO_URI="https://github.com/nielssp/colorgrab"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/wxGTK:3.0"
DEPEND="${RDEPEND}"

src_configure() {
	cmake ${S} -DCMAKE_INSTALL_PREFIX=/usr
}

src_compile() {
	emake
}

src_install() {
	make_desktop_entry ${PN} "ColorGrab" ${PN} "Graphics;GTK;"

	insinto /usr/share/icons/hicolor/scalable/apps/
	newins img/scalable.svg ${PN}.svg

	for size in 16 32 48 64 128 256; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps/
		newins img/${size}x${size}.png ${PN}.png
	done

	dobin ${PN}
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}