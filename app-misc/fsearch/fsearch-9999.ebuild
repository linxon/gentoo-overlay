# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools xdg-utils

DESCRIPTION="A fast file search utility for Unix-like systems based on GTK+3"
HOMEPAGE="https://github.com/cboxdoerfer/fsearch"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cboxdoerfer/fsearch"
else
	MY_PV="${PV%%_*}beta2"
	SRC_URI="https://github.com/cboxdoerfer/fsearch/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE="nls debug"

RDEPEND="
	x11-libs/gtk+:3
	dev-libs/glib:2=
	dev-libs/libpcre"

DEPEND="${RDEPEND}"
BDEPEND="
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myeconfargs=(
		$(use_enable nls) \
		$(use_enable debug)
	)

	econf "${myeconfargs[@]}" || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
