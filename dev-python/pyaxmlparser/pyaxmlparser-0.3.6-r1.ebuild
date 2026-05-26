# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1

DESCRIPTION="Python3 Parser for Android XML file and get Application Name without using Androguard"
HOMEPAGE="https://github.com/appknox/pyaxmlparser"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/appknox/pyaxmlparser"
else
	PKG_HASH="31/98/f18ff9cc406a38670f16b40a41f43dd31032337d482348bc1a5257cd6358"
	SRC_URI="https://pypi.python.org/packages/${PKG_HASH}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${PYTHON_DEPS}
	>=dev-python/lxml-3.7.3"
