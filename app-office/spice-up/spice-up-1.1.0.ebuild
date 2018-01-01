# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
CMAKE_MIN_VERSION="2.6"
VALA_MIN_API_VERSION="0.26"

inherit cmake-utils gnome2-utils vala xdg-utils

DESCRIPTION="Create simple and beautiful presentations"
HOMEPAGE="https://github.com/Philip-Scott/Spice-up"
LICENSE="GPL-3"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Philip-Scott/Spice-up"
else
	MY_P="Spice-up-${PV}"
	SRC_URI="https://github.com/Philip-Scott/Spice-up/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

RESTRICT="mirror"
SLOT="0"

RDEPEND="
	dev-libs/libgee:0.8
	dev-libs/libevdev
	dev-libs/libgudev
	dev-libs/json-glib
	>=dev-libs/granite-0.4.1
	>=x11-libs/gtk+-3.9.10:3"

DEPEND="${RDEPEND}
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig"

src_prepare() {
	vala_src_prepare
	# Change path of valac
	sed -i -e "/NAMES/s:valac:${VALAC}:" cmake/FindVala.cmake || die 'sed failed!'
	# Disable compiling GSettings schemas (fix sandbox warnings while installing)
	sed -i -e 's/GSETTINGS_COMPILE//' cmake/GSettings.cmake || die 'sed failed!'

	cmake-utils_src_prepare
}

src_configure() {
	# Fix error message "Unknown arguments specified"
	export USER=portage

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dosym ./com.github.philip-scott.spice-up /usr/bin/spice-up
	dodoc README.md
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}
