# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit git-r3 python-r1

DESCRIPTION="Download Youtube comments without using the Youtube API"
HOMEPAGE="https://github.com/egbertbouman/youtube-comment-downloader"

EGIT_REPO_URI="https://github.com/egbertbouman/youtube-comment-downloader"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="3f5a183595c62670f4a70355aa171baacebf9564"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]"

src_install() {
	dodoc README.md
	python_foreach_impl python_newscript downloader.py $PN
}
