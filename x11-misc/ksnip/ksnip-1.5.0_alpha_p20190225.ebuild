# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3 gnome2-utils xdg-utils

DESCRIPTION="A Qt based screenshot tool."
HOMEPAGE="https://github.com/DamirPorobic/ksnip"
SRC_URI=""

EGIT_REPO_URI="https://github.com/DamirPorobic/ksnip"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="5664ee0c7ec6d8d69f952c3f853e53d23c603708"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
IUSE="wayland X"

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

src_configure() {
	local mycmakeargs=(
		$(usex wayland)
		$(usex X)
	)

	cmake-utils_src_configure
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
