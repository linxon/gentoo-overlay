# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils xdg-utils

DESCRIPTION="A fast file search utility for Unix-like systems based on GTK+3"
HOMEPAGE="http://www.fsearch.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cboxdoerfer/fsearch"
else
	MY_PV="0.1beta2"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="https://github.com/cboxdoerfer/fsearch/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

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

src_prepare() {
	default
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

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
