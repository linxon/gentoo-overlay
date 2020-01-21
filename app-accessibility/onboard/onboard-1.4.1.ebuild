# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 gnome2-utils

DESCRIPTION="Onscreen keyboard for everybody who can't use a hardware keyboard"
HOMEPAGE="https://launchpad.net/onboard"
SRC_URI="https://launchpad.net/${PN}/$(ver_cut 1-2)/${PV}/+download/${P}.tar.gz"

# po/* are licensed under BSD 3-clause
LICENSE="GPL-3+ BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="
	app-text/hunspell:=
	dev-libs/dbus-glib
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	gnome-base/dconf
	gnome-base/gsettings-desktop-schemas
	gnome-base/librsvg
	media-libs/libcanberra
	sys-apps/dbus
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[introspection]
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXtst
	x11-libs/libwnck:3
	x11-libs/pango"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	app-accessibility/at-spi2-core
	app-text/iso-codes
	gnome-extra/mousetweaks
	x11-libs/libxkbfile"

BDEPEND="
	dev-util/intltool
	virtual/pkgconfig"

# These are using a functionality of distutils-r1.eclass
DOCS=( AUTHORS CHANGELOG HACKING NEWS README onboard-defaults.conf.example
	onboard-default-settings.gschema.override.example )

src_prepare() {
	eapply "${FILESDIR}/${P}-remove-duplicated-docs.patch"

	distutils-r1_src_prepare
	default
}

src_install() {
	distutils-r1_src_install

	# Delete duplicated docs installed by original dustutils
	rm -r "${D}"/usr/share/doc
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
