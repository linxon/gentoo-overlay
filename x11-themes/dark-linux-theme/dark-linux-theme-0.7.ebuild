# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="Dark-linux-0.7"
DESCRIPTION="A simple dark GTK theme for XFCE4/Gnome2"
HOMEPAGE="https://metak.deviantart.com/art/Dark-linux-0-7-150406617"
SRC_URI="https://orig00.deviantart.net/af94/f/2010/187/6/7/dark_linux_0_7_by_metak.zip -> ${P}.zip"

RESTRICT="mirror"
KEYWORDS="amd64 x86"
LICENSE="Unlicense"
SLOT="0"

RDEPEND="
	x11-libs/gtk+:2
	x11-themes/gtk-engines"

S="${WORKDIR}"/${MY_PN}

src_install() {
	insinto "/usr/share/themes/${MY_PN}"
	doins -r *
}

pkg_postinst() {
	elog
	elog "Author comment: This theme is a resoult of my attempt to create a proffesional looking gnome desktop... (let me know if I've made it :))"
	elog "This is basicly improved theme from my earlier no-name-jet version theme..."
	elog "For best look set panel size to 24x."
	elog
	elog "COPY FILE \"/usr/share/themes/${MY_PN}/userContent.css\" to \"/home/<username>/.mozilla/firefox/***.default/chrome\""
	elog
}
