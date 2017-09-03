# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils cmake-utils gnome2-utils xdg-utils

DESCRIPTION="Simple medical records manager"
HOMEPAGE="https://launchpad.net/clinica-project"
SRC_URI="https://launchpad.net/clinica-project/stable/${PV}/+download/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="
	>=dev-lang/vala-0.16.0
	dev-util/intltool"

RDEPEND="
	>=dev-libs/libgee-0.6.0
	>=dev-libs/libpeas-1.0
	dev-python/pygobject:2
	dev-libs/jansson
	gnome-base/librsvg:2
	gnome-extra/yelp
	>=net-libs/libsoup-2.4
	x11-libs/wxGTK:3.0"

src_configure() {
	cmake ${S} -DCMAKE_INSTALL_PREFIX=/usr
}

src_compile() {
	emake
}

src_install() {
	make_desktop_entry "${PN}" "Clinica" "${PN}" "Utility;Office;"
	dobin ${PN}
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}