# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_IN_SOURCE_BUILD=1
WX_GTK_VER="3.0-gtk3"

inherit cmake-utils wxwidgets xdg-utils

DESCRIPTION="A cross-platform graphical client for sending SPA knocks to fwknopd"
HOMEPAGE="https://github.com/jp-bennett/fwknop-gui"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jp-bennett/fwknop-gui"
else
	SRC_URI="https://github.com/jp-bennett/fwknop-gui/archive/v${PV}-release.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${P}-release"
fi

LICENSE="AGPL-3 GPL-3"
SLOT="0"

RDEPEND="
	app-crypt/gpgme
	net-misc/curl
	net-firewall/fwknop
	media-gfx/qrencode
	x11-libs/wxGTK:${WX_GTK_VER}[X]"

DEPEND="${RDEPEND} app-text/asciidoc"
BDEPEND="virtual/pkgconfig"

pkg_setup() {
	setup-wxwidgets
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
