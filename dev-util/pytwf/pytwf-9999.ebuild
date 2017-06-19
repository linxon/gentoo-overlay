# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3

DESCRIPTION="Widget Factory for testing GTK styles/themes"
HOMEPAGE="https://github.com/Aurora-and-Equinox/PyTWF"
EGIT_REPO_URI="https://github.com/Aurora-and-Equinox/PyTWF"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pygtk"

src_install() {
	make_desktop_entry "${PN}" "PyTWF" "preferences-desktop-theme" "Utility;Development;GTK;" "${PN}.desktop"
	dobin PyTWF.py
	dosym /usr/bin/PyTWF.py /usr/bin/${PN}
}
