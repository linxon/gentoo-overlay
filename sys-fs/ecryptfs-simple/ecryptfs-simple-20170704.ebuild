# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A very simple utility for working with eCryptfs."
HOMEPAGE="https://github.com/mhogomchungu/ecryptfs-simple"

MY_PV="2017"
MY_P="${PN}-${MY_PV}"
# Unfortunately, i can't find original src repo
SRC_URI="https://xyne.archlinux.ca/projects/${PN}/src/${MY_P}.tar.xz"

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

S="${WORKDIR}"/${MY_P}
