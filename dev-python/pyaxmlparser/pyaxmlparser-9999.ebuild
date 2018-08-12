# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6,3_7} )

inherit distutils-r1

DESCRIPTION="Python3 Parser for Android XML file and get Application Name without using Androguard"
HOMEPAGE="https://github.com/appknox/pyaxmlparser"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/appknox/pyaxmlparser"
else
	PKG_HASH="9aedc9efc66ad81f8a167f253287a94c16a2cbe8e8818a6dffeba6d7e345"
	SRC_URI="https://pypi.python.org/packages/e9/80/${PKG_HASH}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${PYTHON_DEPS}
	>=dev-python/lxml-3.7.3"
