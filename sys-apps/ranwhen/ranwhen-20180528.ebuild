# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit eutils git-r3 python-r1

DESCRIPTION="Visualize when your system was running."
HOMEPAGE="https://github.com/p-e-w/ranwhen"
SRC_URI=""

EGIT_REPO_URI="https://github.com/p-e-w/ranwhen"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="15b9e5ee0006a5b3b21bacdd86c490fe9662bb6e"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL"
RESTRICT="mirror"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	sys-apps/util-linux"

DEPEND="${RDEPEND}"

src_install() {
	dodoc README.md
	python_foreach_impl python_doscript ranwhen.py

	make_wrapper \
		"${PN}" \
		"python3 /usr/bin/ranwhen.py"
}
