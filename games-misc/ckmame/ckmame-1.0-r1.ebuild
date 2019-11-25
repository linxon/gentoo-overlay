# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A program to check ROM sets for MAME"
HOMEPAGE="https://nih.at/ckmame/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nih-at/ckmame"
else
	MY_PV="rel-${PV/./-}"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="https://github.com/nih-at/ckmame/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-2+"
SLOT="0"

BDEPEND="virtual/pkgconfig"
RDEPEND="
	dev-db/sqlite:3=
	dev-libs/libzip
	dev-libs/libxml2"

DEPEND="${RDEPEND}
	virtual/man"

PATCHES=( "${FILESDIR}" )
