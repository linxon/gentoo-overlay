# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit gnome2-utils meson python-single-r1 xdg-utils

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

RDEPEND="${PYTHON_DEPS}
	dev-libs/glib:=
	$(python_gen_cond_dep '
		dev-python/distro[${PYTHON_MULTI_USEDEP}]
		dev-python/requests[${PYTHON_MULTI_USEDEP}]
		dev-python/pytz[${PYTHON_MULTI_USEDEP}]
		dev-python/pygobject:3[${PYTHON_MULTI_USEDEP}]
		>=dev-python/peewee-3.5.0[${PYTHON_MULTI_USEDEP}]
		media-libs/mutagen[${PYTHON_MULTI_USEDEP}]
	')
	media-libs/gstreamer:1.0=[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/gdk-pixbuf[introspection]
	x11-libs/pango[introspection]"

DEPEND="${RDEPEND}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	meson_src_install
	python_optimize "${ED}/$(python_get_sitedir)"
	dosym ./com.github.geigi.cozy /usr/bin/cozy
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
