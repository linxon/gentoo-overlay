# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4} )

inherit distutils-r1

DESCRIPTION="Stress-Terminal UI monitoring tool"
HOMEPAGE="https://amanusk.github.io/s-tui/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/amanusk/s-tui"
else
	MY_PV="${PV%%_pre}"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="https://github.com/amanusk/s-tui/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"
IUSE="+stress"
DEPEND=""
RDEPEND="${PYTHON_DEPS}
	>=dev-python/urwid-1.3.1[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.2.0
	stress? ( app-benchmarks/stress )"
