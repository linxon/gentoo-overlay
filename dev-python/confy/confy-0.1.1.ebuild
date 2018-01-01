# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Simple config parser and basic strings manipulation"
HOMEPAGE="https://sourceforge.net/projects/pymusicpd"
LICENSE="MIT"

SRC_URI="mirror://sourceforge/pymusicpd/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
SLOT="0"
DEPEND=""
RDEPEND="${PYTHON_DEPS}"

S="${WORKDIR}"/${PN}
