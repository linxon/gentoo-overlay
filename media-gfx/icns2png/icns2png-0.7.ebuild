# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A utility to convert Mac icons to PNG images"
HOMEPAGE="https://github.com/Tookmund/Swapspace"
SRC_URI="http://www.eisbox.net/software/icns2png-${PV}.src.tgz -> ${P}.tar.gz"
KEYWORDS="amd64 x86"
LICENSE="GPL"
SLOT="0"
S="${WORKDIR}"/${PN}
DEPEND=""
RDEPEND="${DEPEND}
	media-libs/libpng:1.2
"
