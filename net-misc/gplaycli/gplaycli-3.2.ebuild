# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5} )

inherit distutils-r1

DESCRIPTION="Google Play Downloader via Command line"
HOMEPAGE="https://github.com/matlink/gplaycli"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/matlink/gplaycli"
else
	SRC_URI="https://github.com/matlink/gplaycli/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
DEPEND=""
RDEPEND="${PYTHON_DEPS}
	>=dev-libs/protobuf-2.4[python]
	>=dev-python/requests-0.12
	dev-python/pyaxmlparser
	dev-python/ndg-httpsclient
	dev-python/clint
	dev-python/pycrypto
	dev-python/gpapi
	dev-libs/libffi"
