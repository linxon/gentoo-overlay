# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )
PLOCALES="da_DK de en_IE es fi fr it ms_MY nl pl pt ru tr"

inherit gnome2-utils meson l10n python-r1 xdg-utils

DESCRIPTION="A modern audio book player for Linux using GTK+ 3"
HOMEPAGE="https://github.com/geigi/cozy"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/geigi/cozy"
	KEYWORDS=""
else
	SRC_URI="https://github.com/geigi/cozy/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE="nls"

RDEPEND="${PYTHON_DEPS}
	dev-libs/glib:2
	dev-python/peewee[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
	media-libs/gstreamer:1.0
	>=x11-libs/gtk+-3.22"

DEPEND="${RDEPEND}
	>=dev-util/meson-0.40.0
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i \
		-e "11d" data/desktop.in || die "sed failed!"

	mv debian/changelog ChangeLog || die

	if use nls; then
		l10n_find_plocales_changes "po" "" ".po"

		rm_loc() { rm -fv po/${1}.{mo,po} || die; }
		l10n_for_each_disabled_locale_do rm_loc

		# Update a LINGUAS file
		echo $(l10n_get_locales) > po/LINGUAS || die
	else
		for x in ${PLOCALES}; do
			rm -fv po/${x}.{mo,po} || die
		done

		# ...
		echo > po/LINGUAS || die
	fi

	eapply_user
}

src_install() {
	meson_src_install

	dosym ./com.github.geigi.cozy /usr/bin/cozy
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
