# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 gnome2-utils

DESCRIPTION="Linux icon theme combining old style and color of material design."
HOMEPAGE="https://github.com/cbrnix/Newaita"
SRC_URI=""

EGIT_REPO_URI="https://github.com/cbrnix/Newaita"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="157863beed3864d94ea3387d0d4419d11498ca92"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="CC-BY-NC-SA-3.0"
SLOT="0"
IUSE=""

src_prepare() {
	default
	rm -fv "${S}"/Newaita{,-dark}/{FV.sh,PV.sh,README.md,License-*} || die
}

src_install() {
	insinto "/usr/share/icons"
	doins -r Newaita{,-dark}

	dodoc README.md
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
