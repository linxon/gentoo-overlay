# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit scons-utils gnome2-utils xdg-utils

DESCRIPTION="Advanced color picker written in C++ using GTK+ toolkit"
HOMEPAGE="http://www.gpick.org/"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/thezbyg/gpick"
else
	MY_P="${PN}-${PN}-${PV}"
	SRC_URI="https://github.com/thezbyg/gpick/archive/gpick-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

LICENSE="BSD"
RESTRICT="mirror"
SLOT="0"
IUSE="dbus debug unique"

RDEPEND="
	>=dev-lang/lua-5.1:0
	>=x11-libs/gtk+-2.12.0:2
	dev-util/lemon
	dev-libs/boost
	dbus? ( >=dev-libs/dbus-glib-0.76 )
	unique? ( >=dev-libs/libunique-1.0.8:1 )"

DEPEND="${RDEPEND}
	>=dev-util/scons-1.0.0"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix_revision.patch
	eapply_user
}

src_compile() {
	export CXXFLAGS="${CXXFLAGS} -std=gnu++98"

	use unique && WITH_UNIQUE=yes
	use dbus && WITH_DBUSGLIB=yes
	use debug && DEBUG=yes

	escons build || die "escons build failed!"
}

src_install() {
	escons DESTDIR="${D}/usr" install \
		|| die "escons install failed!"

	dosym ../icons/hicolor/48x48/apps/gpick.png /usr/share/pixmaps/gpick.png
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
