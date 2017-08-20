# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils xdg-utils

MY_P="${P}-$(getconf LONG_BIT)"
DESCRIPTION="Backerupper is a simple program for backing up selected directories over a local network"
HOMEPAGE="http://sourceforge.net/projects/backerupper/"
SRC_URI="http://downloads.sourceforge.net/backerupper/${MY_P}.tar.gz"
KEYWORDS="amd64 x86"
LICENSE="GPL"
SLOT="0"
RDEPEND="x11-libs/gtk+:2"
S="${WORKDIR}"/${MY_P}

src_install() {
	local inst_path="/opt/${MY_P}"

	insinto "${inst_path}"
	doins -r doc

	exeinto "${inst_path}"
	doexe backer backer
	dosym "${inst_path}"/backer /opt/bin/backer

	make_desktop_entry "/opt/bin/backer" "Backerupper" "document-save" "GNOME;GTK;Utility;" "StartupNotify=true"

	dodoc CHANGELOG LICENSE README
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
