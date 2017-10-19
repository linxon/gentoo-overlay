# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Fast compare two files binary"
HOMEPAGE="http://www.scylla-charybdis.com/tool.php/cmpfast"
LICENSE="GPL-2"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hilbix/cmpfast"
else
	MY_P="${P}-20100330-214523"
	SRC_URI="http://www.scylla-charybdis.com/download/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}"/${MY_P}
fi

RESTRICT="mirror"
SLOT="0"
DEPEND=""
RDEPEND="${DEPEND}
	sys-libs/glibc"

src_compile() {
	emake -j1
}

src_install() {
	dobin ${PN}
	dodoc DESCRIPTION ChangeLog ANNOUNCE
}
