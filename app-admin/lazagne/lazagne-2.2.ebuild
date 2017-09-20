# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit eutils

DESCRIPTION="Credentials recovery project"
HOMEPAGE="https://github.com/AlessandroZ/LaZagne"
LICENSE="LGPL-3"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AlessandroZ/LaZagne"
else
	MY_PN="LaZagne"
	MY_P="${MY_PN}-${PV}"
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/AlessandroZ/LaZagne/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	S="${WORKDIR}"/${MY_P}
fi

RESTRICT="mirror"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/traceback2
	dev-python/pyasn1
	dev-python/memorpy
	dev-python/configparser"

src_install() {
	insinto /usr/share/${PN}
	doins -r Linux/lazagne Linux/laZagne.py
	dodoc README.md CHANGELOG

	make_wrapper "${PN}" "python2 /usr/share/${PN}/laZagne.py"
}

pkg_postinst() {
	elog
	elog "See documentation: https://github.com/AlessandroZ/LaZagne#usage"
	elog
}
