# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A Tunnel which turns UDP Traffic into Encrypted FakeTCP/UDP/ICMP Traffic by using Raw Socket,helps you Bypass UDP FireWalls(or Unstable UDP Environment)"
HOMEPAGE="https://github.com/wangyu-/udp2raw-tunnel"
LICENSE="MIT"

SRC_URI=""
EGIT_REPO_URI="https://github.com/wangyu-/udp2raw-tunnel"

if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
SLOT="0"

DEPEND=""
RDEPEND=""

src_install() {
	local ex_name="${PN%%-tunnel}"
	dobin ${ex_name}
	dodoc LICENSE.md README.md
	dodoc -r doc/*
}

pkg_postinst() {
	ewarn
	ewarn "See documentation: https://github.com/wangyu-/udp2raw-tunnel#udp2raw-tunnel"
	ewarn
}