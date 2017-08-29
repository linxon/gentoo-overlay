# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils eutils

DESCRIPTION="Lightweight load monitoring tool written in C"
HOMEPAGE="https://github.com/Dundee/Cimon"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Dundee/Cimon"
else
	MY_P="Cimon-${PV}"
	SRC_URI="https://github.com/Dundee/Cimon/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

KEYWORDS="amd64 ~x86"
LICENSE="GPL"
SLOT="0"

DEPEND="dev-util/cunit"
RDEPEND="${DEPEND}
	net-analyzer/rrdtool
	net-libs/libmicrohttpd
"
src_compile() {
	cmake -D DEBUG_MODE:BOOL=OFF -D REFRESH_GRAPH_INTERVAL:STRING="600" -D PORT:STRING="8080" .
}

src_install() {
	emake install
}
