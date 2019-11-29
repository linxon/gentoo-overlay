# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils xdg-utils

DESCRIPTION="A graphical hardware temperature monitor"
HOMEPAGE="https://wpitchoune.net/psensor/"
SRC_URI="https://wpitchoune.net/psensor/files/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="+gtop +hddtemp nls +server +udisks X"

BDEPEND="nls? ( sys-devel/gettext )"
RDEPEND="
	dev-libs/json-c
	dev-libs/glib:2
	dev-libs/libatasmart
	gnome-base/dconf
	gtop? ( gnome-base/libgtop:2= )
	hddtemp? ( app-admin/hddtemp )
	net-misc/curl
	server? ( net-libs/libmicrohttpd )
	sys-apps/lm-sensors
	udisks? ( sys-fs/udisks:2 )
	X? (
		x11-libs/gtk+:3
		x11-libs/libnotify
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/cairo
	)"

DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}_fix_errors.patch )

src_configure() {
	local econfargs=(
		$(use_with gtop)
		$(use_enable nls)
		$(use_with X x)
	)

	econf "${econfargs[@]}" || die
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
