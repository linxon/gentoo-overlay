# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="My simple scripts"
HOMEPAGE="http://www.linxon.ru"
SRC_URI=""
KEYWORDS="amd64 x86"
RESTRICT="mirror"
LICENSE="Unlicense"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash
	virtual/awk"

src_unpack() {
	unpack "${FILESDIR}"/${P}.tar.gz
}

src_install() {
	# autorun-scriptd
	exeinto /etc/xdg/autorun-script.d
	doexe autorun-scriptd/autorun-script.d/*
	insinto /etc/xdg/autostart/
	doins autorun-scriptd/autorun-scriptd.desktop
	dobin autorun-scriptd/autorun-scriptd.sh

	# mf823
	dobin mf823/mf823

	# mozilla-addon_get_hash
	dobin mozilla-addon_get_hash/mozilla-addon_get_hash.sh

	# pwgen_urandom
	dobin pwgen_urandom/pwgen_urandom.sh

	# video-to-gif
	dobin video-to-gif/video-to-gif.sh

	# toggle-conky
	dobin toggle-conky/toggle-conky.sh

	# toggle-monitor
	dobin toggle-monitor/toggle-monitor.sh
	make_desktop_entry \
		"toggle-monitor.sh" \
		"Enable/Disable monitor" \
		"xfce-display-internal" \
		"System;Settings;"

	# linxons-skel
	insinto /usr/share
	doins -r linxons-skel
}
