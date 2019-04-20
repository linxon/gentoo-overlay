# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3 gnome2-utils xdg-utils

DESCRIPTION="A Qt based screenshot tool"
HOMEPAGE="https://github.com/DamirPorobic/ksnip"
SRC_URI=""

EGIT_REPO_URI="https://github.com/DamirPorobic/ksnip"
EGIT_COMMIT="36e2bd32d73323542a41431268990232c07f3c85"

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5[ssl]
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5[png]
	dev-qt/qtxml:5
	dev-qt/qtx11extras:5
	x11-libs/kcolorpicker
	x11-libs/kimageannotator
	x11-libs/libxcb"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	cmake-utils_src_prepare
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}