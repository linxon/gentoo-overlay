# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit vala cmake-utils gnome2-utils xdg-utils

DESCRIPTION="Simple medical records manager"
HOMEPAGE="https://launchpad.net/clinica-project"
LICENSE="GPL-3"
SRC_URI="https://launchpad.net/clinica-project/stable/${PV}/+download/${P}.tar.bz2"
RESTRICT="mirror test userpriv"
KEYWORDS="amd64 ~x86"
IUSE="-doc"
SLOT="0"

RDEPEND="
	>=dev-libs/libgee-0.6.0:0
	>=dev-libs/libpeas-1.0
	dev-libs/glib:2
	dev-python/pygobject:2
	dev-libs/jansson
	gnome-base/librsvg:2
	doc? ( gnome-extra/yelp )
	>=net-libs/libsoup-2.4
	x11-libs/wxGTK:3.0"

# >=dev-lang/vala-0.16.0 — vala_src_prepare cant find valac version 
# for fix it i use a patch. Now you can use only 0.34 version of vala.
DEPEND="${RDEPEND}
	dev-lang/vala:0.34
	dev-util/intltool"

src_prepare() {
	vala_src_prepare

	eapply "${FILESDIR}"
	eapply_user
}

src_configure() {
	cmake ${S} -DCMAKE_INSTALL_PREFIX=/usr \
               -DGSETTINGS_COMPILE=OFF \
               -DGSETTINGS_COMPILE_IN_PLACE=OFF \
               -DCMAKE_SKIP_RPATH=ON \
               -DCMAKE_BUILD_TYPE=Release || die
}

src_compile() {
	emake DESTDIR="${D}" || die "compile error"
}

src_install() {
	emake DESTDIR="${D}" install || die "install error"
}

pkg_preinst() {
	gnome2_schemas_savelist 
	gnome2_icon_savelist
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