# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )
PYTHON_REQ_USE="ssl"

inherit python-r1

DESCRIPTION="A command line client for Yandex.Disk"
HOMEPAGE="https://github.com/abbat/ydcmd"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/abbat/ydcmd"
else
	SRC_URI="https://github.com/abbat/ydcmd/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	app-misc/ca-certificates
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/progressbar[${PYTHON_USEDEP}]"

src_prepare() {
	mv debian/changelog ChangeLog || die
	mv README.md README.ru.md && mv README.en.md README.md || die

	default
}

src_install() {
	dodoc -r README.md README.ru.md ChangeLog examples ydcmd.cfg
	doman man/ydcmd.1 man/ydcmd.ru.1 man/ydcmd.tr.1

	python_foreach_impl python_newscript ydcmd.py ydcmd
}
