# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
CMAKE_MIN_VERSION="2.8.11"
BUILD_DIR="${S}"

inherit eutils cmake-utils gnome2-utils xdg-utils wxwidgets

DESCRIPTION="A cross-platform graphical client for sending SPA knocks to fwknopd."
HOMEPAGE="https://github.com/jp-bennett/fwknop-gui"
LICENSE="GPL-3"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jp-bennett/fwknop-gui"
else
	MY_PV="${PV}-release"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="https://github.com/jp-bennett/fwknop-gui/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

RESTRICT="mirror"
SLOT="0"

RDEPEND="
	app-crypt/gpgme
	dev-qt/qtcore:5
	net-misc/curl
	net-firewall/fwknop[client]
	media-gfx/qrencode
	media-libs/libjpeg-turbo
	media-libs/libpng:0
	sys-libs/glibc
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/pango
	x11-libs/cairo
	x11-libs/wxGTK:3.0"

DEPEND="${RDEPEND}"

src_prepare() {
	cp -v fwknop-gui.8.asciidoc fwknop-gui.8
	cmake-utils_src_prepare
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
