# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="A mastodon CLI client."
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
	>=dev-python/beautifulsoup-4.5.0:4[${PYTHON_USEDEP}]
	>=dev-python/wcwidth-0.1.7[${PYTHON_USEDEP}]"

src_prepare() {
	sed -e "s/data_files=\[('', \['Makefile'\])\],//" \
		-i setup.py || die 'sed failed!'

	eapply_user
}
