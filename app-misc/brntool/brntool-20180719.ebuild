# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit git-r3 python-r1

DESCRIPTION="This tool can, so far, given a serial port connected to a device with brnboot/amazonboot, dump its flash into a file"
HOMEPAGE="https://github.com/rvalles/brntool"

SRC_URI=""
EGIT_REPO_URI="https://github.com/rvalles/brntool"

if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="dfcf27503d952919d7a46e6a7ee1eef048b2b151"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/pyserial"

DEPEND="${RDEPEND}"

src_install() {
	python_foreach_impl python_doscript ${PN}.py
	dodoc README.md
}
