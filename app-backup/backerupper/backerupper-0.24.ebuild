# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils xdg-utils

DESCRIPTION="Backerupper is a simple program for backing up selected directories over a local network"
HOMEPAGE="http://sourceforge.net/projects/backerupper/"
LICENSE="GPL-2"

SRC_URI="amd64? ( http://downloads.sourceforge.net/backerupper/${P}-64.tar.gz )
         x86? ( http://downloads.sourceforge.net/backerupper/${P}-32.tar.gz )"

RESTRICT="mirror test"
KEYWORDS="amd64 x86"
SLOT="0"

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}"/${P}-* "${WORKDIR}"/${P} || die
}

src_install() {
	local inst_path="/opt/${P}"

	insinto "${inst_path}"
	doins -r doc

	exeinto "${inst_path}"
	doexe backer
	dosym "${inst_path}"/backer /opt/bin/backer

	make_desktop_entry "/opt/bin/backer" "Backerupper" "document-save" "GNOME;GTK;Utility;" "StartupNotify=true"

	dodoc CHANGELOG README
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
