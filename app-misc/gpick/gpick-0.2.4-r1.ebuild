# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils scons-utils toolchain-funcs xdg-utils

DESCRIPTION="Advanced color picker written in C++ using GTK+ toolkit."
HOMEPAGE="http://www.gpick.org/"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/thezbyg/gpick"
else
	MY_P="${PN}-${PN}-${PV}"
	SRC_URI="https://github.com/thezbyg/gpick/archive/gpick-${PV}.tar.gz"
	KEYWORDS="amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

LICENSE="BSD"
RESTRICT="mirror"
SLOT="0"
IUSE="dbus debug unique"

RDEPEND="
	>=dev-lang/lua-5.1:0
	>=dev-libs/expat-2.0.1
	dbus? ( >=dev-libs/dbus-glib-0.88 )
	unique? ( >=dev-libs/libunique-1.0.8:1 )
	>=x11-libs/cairo-1.2.4
	>=x11-libs/gtk+-2.12.0:2"

DEPEND="${RDEPEND}
	dev-util/lemon
	dev-util/scons"

src_prepare() {
	epatch "${FILESDIR}"/${P}-update-SConscript.patch
	epatch "${FILESDIR}"/${P}-fix_revision.patch
	eapply_user
}

src_configure() {
	MYSCONS=(
		CC="$(tc-getCC)"
		WITH_UNIQUE=$(usex unique)
		WITH_DBUSGLIB=$(usex dbus)
		DEBUG=$(usex debug)
	)
}

src_compile() {
	escons "${MYSCONS[@]}" build \
		|| die "escons build failed!"
}

src_install() {
	escons DESTDIR="${D}/usr" install \
		|| die "escons install failed!"
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
