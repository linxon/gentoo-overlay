# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# На данный момент этот сканер не поддерживать gentoo based дистрибутивы (установка этого пакета бессмысленна)
# в будущем, возможно от разрабочиков мы получим версию, которая умеет gentoo based

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4} )

inherit distutils-r1

DESCRIPTION="Vulnerability scanner based on vulners.com audit API"
HOMEPAGE="https://vulners.com/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/videns/vulners-scanner"
else
	SRC_URI="https://github.com/videns/vulners-scanner/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
RESTRICT="nomirror"
DEPEND=""
RDEPEND="${DEPEND}
	dev-python/urllib3
"

src_compile() {
	# skip
	return
}
src_install() {
	ewarn ""
	ewarn "Gentoo based temporary is not supported!"
	ewarn ""
	ewarn "See documentation: https://github.com/videns/vulners-scanner/blob/master/README.md"
	ewarn ""

	die
}