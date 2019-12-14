# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A small thunar extension displaying the metadata in a torrent file"
HOMEPAGE="https://github.com/althonos/thunar-torrent-property"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/althonos/thunar-torrent-property"
else
	HASH_COMMIT="69d6b28546087913d222335f5d405e5c1c89c1fe"

	SRC_URI="https://github.com/althonos/thunar-torrent-property/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-libs/boost
	dev-libs/glib
	net-libs/libtorrent-rasterbar
	x11-libs/gtk+:*
	xfce-base/thunar"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
