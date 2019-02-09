# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A very simple utility for working with eCryptfs."
HOMEPAGE="https://github.com/mhogomchungu/ecryptfs-simple"

MY_PV="2016.11.16.1"
SRC_URI="https://github.com/mhogomchungu/ecryptfs-simple/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/libgcrypt:0=
	dev-libs/nspr
	sys-apps/keyutils
	sys-fs/ecryptfs-utils"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"/${PN}-${MY_PV}
