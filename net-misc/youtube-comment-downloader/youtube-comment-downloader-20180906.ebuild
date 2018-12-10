# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit eutils git-r3 python-r1

DESCRIPTION="Download Youtube comments without using the Youtube API."
HOMEPAGE="https://github.com/egbertbouman/youtube-comment-downloader"
SRC_URI=""

EGIT_REPO_URI="https://github.com/egbertbouman/youtube-comment-downloader"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="c776ae568ebf27297139ee0e3efaa74fe4bc2621"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
RESTRICT="mirror"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${PYTHON_DEPS}
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]"

src_prepare() {
	mv -v downloader.py ${PN}.py || die
	eapply_user
}

src_install() {
	dodoc README.md
	python_foreach_impl python_doscript ${PN}.py

	make_wrapper \
		"${PN}" \
		"python2 /usr/bin/${PN}.py"
}

pkg_postinst() {
	elog
	elog "See documentation: https://github.com/egbertbouman/youtube-comment-downloader#usage"
	elog
}
