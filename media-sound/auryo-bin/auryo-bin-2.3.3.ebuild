# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker gnome2-utils xdg-utils

DESCRIPTION="Unofficial Soundcloud Desktop App"
HOMEPAGE="https://github.com/Superjo149/auryo"
SRC_URI="amd64? ( https://github.com/Superjo149/auryo/releases/download/v${PV}/auryo_${PV}_amd64.deb )"
KEYWORDS="-* ~amd64"
LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
IUSE=""

QA_PRESTRIPPED="
	/opt/Auryo/auryo
	/opt/Auryo/libffmpeg.so
	/opt/Auryo/libEGL.so
	/opt/Auryo/libGLESv2.so"

RDEPEND="
	gnome-base/gconf:2
	dev-libs/atk
	dev-libs/nss
	dev-libs/libappindicator:2
	dev-libs/nspr
	dev-libs/gmp
	!media-sound/auryo
	media-libs/alsa-lib
	media-libs/freetype
	media-gfx/graphite2
	net-libs/gnutls
	net-dns/libidn2
	x11-libs/gtk+:3
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	x11-libs/libnotify
	x11-libs/libXtst
	x11-libs/libXinerama"

DEPEND=""

S="${WORKDIR}"

src_prepare() {
	rm -fr usr/share/doc \
		usr/share/applications/auryo.desktop

	eapply_user
}

src_install() {
	cp -Rp . "${D}/" || die

	make_desktop_entry \
		"/opt/Auryo/auryo" \
		"Auryo" \
		"auryo" \
		"AudioVideo;Audio;Network;"
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
