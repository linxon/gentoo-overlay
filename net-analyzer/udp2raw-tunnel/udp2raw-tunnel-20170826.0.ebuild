# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A Tunnel which turns UDP Traffic into Encrypted FakeTCP/UDP/ICMP Traffic by using Raw Socket,helps you Bypass UDP FireWalls(or Unstable UDP Environment)"
HOMEPAGE="https://github.com/wangyu-/udp2raw-tunnel"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/wangyu-/udp2raw-tunnel"
else
	SRC_URI="https://github.com/wangyu-/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="doc "

DEPEND=""
RDEPEND=""

src_install() {
	local ex_name="${PN%%-tunnel}"
	dobin ${ex_name}
	dodoc LICENSE.md README.md
}

pkg_postinst() {
	ewarn
	ewarn "See documentation: https://github.com/wangyu-/udp2raw-tunnel#udp2raw-tunnel"
	ewarn
}