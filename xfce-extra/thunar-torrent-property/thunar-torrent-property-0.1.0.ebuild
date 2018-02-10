# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
CMAKE_MIN_VERSION="2.8"
BUILD_DIR="${S}"

inherit cmake-utils

DESCRIPTION="A small thunar extension displaying the metadata in a torrent file"
HOMEPAGE="https://github.com/althonos/thunar-torrent-property"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/althonos/thunar-torrent-property"
else
	SRC_URI="https://github.com/althonos/thunar-torrent-property/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"

RDEPEND="
	dev-libs/boost
	>=dev-libs/glib-2.44:2
	>=net-libs/libtorrent-rasterbar-1.1.0
	xfce-base/thunar
	x11-libs/gtk+:2"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_postinst() {
	ewarn
	ewarn "Just restart a Thunar! :)"
	ewarn
}
