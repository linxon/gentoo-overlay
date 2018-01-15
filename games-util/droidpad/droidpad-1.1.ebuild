# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils xdg-utils

DESCRIPTION="DroidPad lets you use an Android mobile to control a joystick or mouse"
HOMEPAGE="https://www.digitalsquid.co.uk/droidpad/"
SRC_URI="https://launchpad.net/droidpad-linux/1.0/${PV}/+download/${P}.tar.gz"
KEYWORDS="amd64 ~x86"
LICENSE="GPL-2+"
RESTRICT="mirror"
SLOT="0"
IUSE="nls"

RDEPEND="
	dev-util/android-tools
	dev-libs/openssl
	x11-libs/gksu
	>=dev-cpp/gtkmm-2.8.0"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

src_prepare() {
	eautoreconf

	eapply "${FILESDIR}"
	eapply_user
}

src_configure() {
	econf $(use_enable nls)
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
