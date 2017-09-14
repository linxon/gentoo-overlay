# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="COde COnverter on Tty"
HOMEPAGE="http://vmi.jp/software/cygwin/cocot.html"
LICENSE="BSD"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vmi/cocot"
else
	MY_P="${P}-20120313"
	SRC_URI="https://github.com/vmi/cocot/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${PN}-${MY_P}
fi

RESTRICT="mirror"
SLOT="0"
DEPEND=""
RDEPEND="${DEPEND}
	sys-libs/glibc"

src_install() {
	dobin ${PN}
	dodoc README NEWS INSTALL ChangeLog AUTHORS
}
