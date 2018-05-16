# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Mastodon CLI client"
HOMEPAGE="https://joinmastodon.org/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ihabunek/toot"
else
	SRC_URI="https://github.com/ihabunek/toot/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="${PYTHON_DEPS}
	>=dev-python/requests-2.13[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup-4.5.0:4[${PYTHON_USEDEP}]"
