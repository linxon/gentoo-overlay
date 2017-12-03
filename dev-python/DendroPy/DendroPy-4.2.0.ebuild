# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="A Python library for phylogenetic scripting, simulation, data processing and manipulation"
HOMEPAGE="https://github.com/jeetsukumaran/DendroPy"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jeetsukumaran/DendroPy"
else
	SRC_URI="https://github.com/jeetsukumaran/DendroPy/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="all-rights-reserved"
RESTRICT="mirror"
SLOT="0"
DEPEND=""
RDEPEND="${PYTHON_DEPS}"
DOCS=( AUTHORS.rst CHANGES.rst README.rst )

pkg_postinst() {
	elog
	elog "API documentation: http://dendropy.org/library/index.html"
	elog
}
