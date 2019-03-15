# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils gnome2-utils xdg-utils

DESCRIPTION="A Qt based screenshot tool."
HOMEPAGE="https://github.com/DamirPorobic/ksnip"
SRC_URI="https://github.com/DamirPorobic/ksnip/archive/v${PV}.tar.gz -> ${P}.tar.gz"
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
	sed -e "s:ksnip RUNTIME DESTINATION /bin:ksnip RUNTIME DESTINATION /usr/bin:" \
		-i src/CMakeLists.txt || die 'sed failed!'

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
