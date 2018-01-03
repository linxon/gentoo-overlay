# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1 git-r3

DESCRIPTION="Get all passwords stored by Chrome/Chromium"
HOMEPAGE="https://github.com/hassaanaliw/chromepass"
LICENSE="MIT"
SRC_URI=""

EGIT_REPO_URI="https://github.com/hassaanaliw/chromepass"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="d956ddd0c47c61537a1ef4e6ae65050228f5c1bb"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
SLOT="0"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

src_prepare() {
	eapply "${FILESDIR}"
	eapply_user
}

src_install() {
	dodoc README.md
	python_foreach_impl python_doscript ${PN}.py

	make_wrapper \
		"${PN}" \
		"python2 /usr/bin/${PN}.py"
}
