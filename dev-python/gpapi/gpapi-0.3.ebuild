# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4} )

inherit distutils-r1

DESCRIPTION="Google Play Unofficial Python API"
HOMEPAGE="https://github.com/NoMore201/googleplay-api"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/NoMore201/googleplay-api"
else
	MY_P="googleplay-api-${PV}"
	SRC_URI="https://github.com/NoMore201/googleplay-api/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${MY_P}
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

DOCS=( README.md Documentation )

DEPEND=""
RDEPEND="${PYTHON_DEPS}
	dev-python/pycryptodome
	dev-libs/protobuf
	dev-python/clint
	dev-python/requests"
