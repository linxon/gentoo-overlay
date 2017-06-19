# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3 gnome2-utils xdg-utils

DESCRIPTION="Widget Factory for testing GTK styles/themes"
HOMEPAGE="https://github.com/Aurora-and-Equinox/PyTWF"
EGIT_REPO_URI="https://github.com/Aurora-and-Equinox/PyTWF"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pygtk"

src_prepare() {
	eapply_user
	epatch "${FILESDIR}"/fix_env.pacth
}

src_install() {
	make_desktop_entry "${PN}" "PyTWF" "preferences-desktop-theme" "Utility;Development;GTK;"

	insinto /usr/share/pytwf/
	newins "${S}"/twf.builder twf.builder

	mv "${S}"/PyTWF.py "${S}"/${PN}

	dobin ${PN}
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
