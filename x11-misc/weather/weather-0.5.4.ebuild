# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
VALA_MIN_API_VERSION="0.26"
PLOCALES="en es fr lt pt ru"

inherit gnome2-utils meson l10n vala xdg-utils

DESCRIPTION="A forecast application using OpenWeatherMap API"
HOMEPAGE="https://github.com/bitseater/weather"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bitseater/weather"
	KEYWORDS=""
else
	SRC_URI="https://github.com/bitseater/weather/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE="nls"

RDEPEND="
	dev-libs/libappindicator:3
	>=dev-libs/json-glib-1.0[introspection]
	net-libs/libsoup:2.4
	net-libs/webkit-gtk:4
	media-libs/clutter:1.0[gtk]
	media-libs/clutter-gtk:1.0[introspection]
	media-libs/libchamplain:0.12[gtk]
	sci-geosciences/geocode-glib[introspection]
	x11-libs/gtk+:3[introspection]"

DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	>=dev-util/meson-0.40.0
	nls? ( sys-devel/gettext )"

src_prepare() {
	vala_src_prepare

	mv debian/changelog ChangeLog || die

	if use nls; then
		l10n_find_plocales_changes "po" "" ".po"

		rm_loc() { rm -f po/${1}.{mo,po} || die; }
		l10n_for_each_disabled_locale_do rm_loc

		# Update a LINGUAS file
		echo $(l10n_get_locales) > po/LINGUAS || die
	else
		for x in ${PLOCALES}; do
			rm -f po/${x}.{mo,po} || die
		done

		echo > po/LINGUAS || die
	fi

	eapply_user
}

src_install() {
	meson_src_install

	dosym ./com.github.bitseater.weather /usr/bin/weather
	dodoc ChangeLog
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
