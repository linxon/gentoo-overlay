# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A declarative layer on top of SQLAlchemy"
HOMEPAGE="http://elixir.ematia.de/"

PKG_HASH="0009e2a623849894131f258529fe3a818c5734f7a9892f8721d99bd5cc31"
SRC_URI="https://pypi.python.org/packages/3d/8d/${PKG_HASH}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
DEPEND=""
RDEPEND="${PYTHON_DEPS}"
