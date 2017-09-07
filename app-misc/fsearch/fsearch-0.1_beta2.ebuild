# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils xdg-utils

DESCRIPTION="A fast file search utility for Unix-like systems based on GTK+3"
HOMEPAGE="http://www.fsearch.org/"
LICENSE="GPL-2+"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cboxdoerfer/fsearch"
else
	MY_PV="${PV%%_*}beta2"
	SRC_URI="https://github.com/cboxdoerfer/fsearch/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${PN}-${MY_PV}
fi

RESTRICT="mirror"
SLOT="0"
IUSE="nls debug"

RDEPEND="
	>=x11-libs/gtk+-3.12:3
	>=dev-libs/glib-2.36:2
	dev-libs/libpcre"

DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	local myeconfargs=(
		$(use_enable nls) \
		$(use_enable debug)
	)

	econf "${myeconfargs[@]}" || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
