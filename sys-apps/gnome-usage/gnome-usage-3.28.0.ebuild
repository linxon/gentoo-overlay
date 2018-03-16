# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
VALA_MIN_API_VERSION="0.26"
PLOCALES="ca cs de es fi fr fur gl hr hu id it nb nl pl pt_BR sk sl sr sr@latin sv tr"

inherit gnome2-utils meson l10n vala xdg-utils

DESCRIPTION="View system usage information"
HOMEPAGE="http://www.gnome.org/"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/GNOME/gnome-usage"
	KEYWORDS=""
else
	SRC_URI="https://github.com/GNOME/gnome-usage/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="nls"

RDEPEND="
	>=dev-libs/glib-2.38:2
	>=gnome-base/libgtop-2.34.0:2[introspection]
	>=x11-libs/gtk+-3.20.10:3[introspection]"

DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	>=dev-util/meson-0.37.0
	nls? ( sys-devel/gettext )"

src_prepare() {
	vala_src_prepare

	if use nls; then
		l10n_find_plocales_changes "po" "" ".po"

		rm_loc() { rm -f po/${1}.po || die; }
		l10n_for_each_disabled_locale_do rm_loc

		# Update a LINGUAS file
		echo $(l10n_get_locales) > po/LINGUAS || die
	else
		for x in ${PLOCALES}; do
			rm -f po/${x}.po || die
		done

		echo > po/LINGUAS || die
	fi

	eapply_user
}

pkg_preinst() {
	gnome2_schemas_savelist
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
}
