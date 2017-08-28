# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils xdg-utils

DESCRIPTION="A graphical hardware temperature monitor for GNU/Linux"
HOMEPAGE="http://wpitchoune.net/psensor"
SRC_URI="http://wpitchoune.net/${PN}/files/${PN}-${PV}.tar.gz"
KEYWORDS="amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="+gtop nls X"
DEPEND="sys-apps/help2man"
RDEPEND="${DEPEND}
	gnome-base/dconf
	sys-fs/udisks:2
	>=x11-libs/gtk+-3.4:3
	gtop? ( gnome-base/libgtop )
"

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