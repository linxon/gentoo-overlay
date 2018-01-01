# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Python library using ctypes to search/edit windows / linux / macOS / SunOS programs memory"
HOMEPAGE="https://github.com/n1nj4sec/memorpy"
LICENSE="BSD"

SRC_URI=""
EGIT_REPO_URI="https://github.com/n1nj4sec/memorpy"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="adcc002045a6db29f2d3f3b5666fb4a90bab1bd5"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
DEPEND=""
RDEPEND="${PYTHON_DEPS}"
