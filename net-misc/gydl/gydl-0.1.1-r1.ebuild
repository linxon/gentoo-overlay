# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6,7} )
PLOCALES="sv"

inherit gnome2-utils meson l10n python-r1 xdg-utils

DESCRIPTION="A GUI wrapper around the already existing youtube-dl program."
HOMEPAGE="https://github.com/JannikHv/gydl"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/JannikHv/gydl"
	KEYWORDS=""
else
	SRC_URI="https://github.com/JannikHv/gydl/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

RDEPEND="${PYTHON_DEPS}
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	net-misc/youtube-dl
	>=x11-libs/gtk+-3.22"

DEPEND="${RDEPEND}
	>=dev-util/meson-0.40.0
	nls? ( sys-devel/gettext )"

src_prepare() {
	if use nls; then
		l10n_find_plocales_changes "po" "" ".po"
		rm_loc() { rm -fv po/${1}.{mo,po} || die; }
		l10n_for_each_disabled_locale_do rm_loc

		echo $(l10n_get_locales) > po/LINGUAS || die
	else
		for x in ${PLOCALES}; do
			rm -fv po/${x}.{mo,po} || die
		done

		echo > po/LINGUAS || die
	fi

	eapply_user
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
