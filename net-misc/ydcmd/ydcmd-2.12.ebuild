# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6,3_7} )

inherit eutils python-r1

DESCRIPTION="A command line client for Yandex.Disk using REST API."
HOMEPAGE="https://github.com/abbat/ydcmd"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/abbat/ydcmd"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/abbat/ydcmd/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="BSD"
RESTRICT="mirror"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${PYTHON_DEPS}
	app-misc/ca-certificates
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/progressbar[${PYTHON_USEDEP}]"

src_prepare() {
	mv debian/changelog ChangeLog || die
	mv README.md README.ru.md && mv README.en.md README.md || die

	eapply_user
}

src_install() {
	dodoc -r README.md README.ru.md ChangeLog examples ydcmd.cfg
	doman man/ydcmd.1 man/ydcmd.ru.1 man/ydcmd.tr.1

	python_foreach_impl python_doscript ydcmd.py

	make_wrapper \
		"ydcmd" \
		"python3 /usr/bin/ydcmd.py"
}
