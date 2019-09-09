# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6} )

inherit gnome2-utils meson python-r1 xdg-utils

DESCRIPTION="A modern audio book player"
HOMEPAGE="https://github.com/geigi/cozy"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/geigi/cozy"
else
	SRC_URI="https://github.com/geigi/cozy/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-libs/glib:=
	>=dev-python/peewee-3.5.0[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
	media-libs/gstreamer:1.0=[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/gdk-pixbuf[introspection]
	x11-libs/pango[introspection]"

DEPEND="${RDEPEND}"

src_install() {
	meson_src_install
	dosym ./com.github.geigi.cozy /usr/bin/cozy
}

pkg_preinst() {
	gnome2_icon_savelist
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
