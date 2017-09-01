# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A program to check ROM sets for MAME"
HOMEPAGE="https://nih.at/ckmame/"
SRC_URI="https://nih.at/ckmame/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND="
	virtual/pkgconfig
	virtual/man"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/libzip
	dev-libs/libxml2"
