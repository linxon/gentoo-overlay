# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Collection of Python scripts for reading information about and extracting data from UBI and UBIFS images"
HOMEPAGE="https://github.com/jrspruitt/ubi_reader"
LICENSE="GPL-3"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jrspruitt/ubi_reader"
else
	MY_PV="${PV%%.0}"
	MY_P="${PN}-${MY_PV}_ui"
	SRC_URI="https://github.com/jrspruitt/ubi_reader/archive/v${MY_PV}_ui.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

SLOT="0"
RESTRICT="mirror"
RDEPEND="dev-python/python-lzo[${PYTHON_USEDEP}]"
