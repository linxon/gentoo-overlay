# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="One Color Picker to rule them all"
HOMEPAGE="https://github.com/RonnyDo/ColorPicker"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/RonnyDo/ColorPicker"
else
	SRC_URI="https://github.com/RonnyDo/ColorPicker/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	S="${WORKDIR}/ColorPicker-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-libs/glib:=
	dev-libs/granite[introspection]
	x11-libs/gtk+:3[introspection]
	$(vala_depend)"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	vala_src_prepare
}

src_install() {
	meson_src_install
	dosym ./com.github.ronnydo.colorpicker /usr/bin/colorpicker
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	gnome2_schemas_update
}
