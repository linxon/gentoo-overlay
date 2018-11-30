# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
CMAKE_MIN_VERSION="3.0.2"
BUILD_DIR="${S}"

inherit cmake-utils

DESCRIPTION="A program to check ROM sets for MAME"
HOMEPAGE="https://nih.at/ckmame/"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nih-at/ckmame"
else
	MY_PV="rel-${PV/./-}"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="https://github.com/nih-at/ckmame/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

RESTRICT="mirror"
LICENSE="GPL-2+"
SLOT="0"
IUSE=""

RDEPEND="
	dev-db/sqlite:3
	dev-libs/libzip
	dev-libs/libxml2"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	virtual/man"

src_prepare() {
	cmake-utils_src_prepare
}

src_install() {
	cmake-utils_src_install

	for manpage in docs/*.man; do
		mv -v "${manpage}" "${manpage%.man}.1" || die
		doman "${manpage%.man}.1"
	done

	dodoc \
		"docs/mame-0.96.dtd" \
		"docs/mess-0.97.dtd" \
		"docs/softwarelist.dtd" \
		"docs/datafile.dtd" \
		"docs/wwwprofiler.txt" \
		"docs/xmlheaders.txt" \
		"docs/db-format"
}
