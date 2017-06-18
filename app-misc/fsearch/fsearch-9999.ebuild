# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools gnome2-utils xdg-utils

DESCRIPTION="A fast file search utility for Unix-like systems based on GTK+3"
HOMEPAGE="http://www.fsearch.org/"
EGIT_REPO_URI="https://github.com/cboxdoerfer/fsearch"
LICENSE="GPL-2+"
SLOT="0"
IUSE="debug"

CDEPEND="
	>=x11-libs/gtk+-3.12:3
	>=dev-libs/glib-2.36:2
	dev-libs/libpcre"
DEPEND="${CDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"
RDEPEND="${CDEPEND}"

S="${WORKDIR}/${PN}-9999"

src_prepare() {
	eapply_user
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
	)

	econf "${myeconfargs[@]}" || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
