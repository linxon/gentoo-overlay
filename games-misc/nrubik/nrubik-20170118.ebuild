# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit eutils git-r3 python-r1

DESCRIPTION="An N-Curses Based, Virtual Rubik's Cube "
HOMEPAGE="https://github.com/calebabutler/nrubik"

EGIT_REPO_URI="https://github.com/calebabutler/nrubik"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="93c9627ebae9449cb5cf2d02305ef1f6091096fd"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${PYTHON_DEPS}"

src_install() {
	dodoc README.md
	python_foreach_impl python_doscript ${PN}
}
