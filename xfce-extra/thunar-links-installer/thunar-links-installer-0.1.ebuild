# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Make a short links for thunar"
HOMEPAGE="https://xfce.org/"
LICENSE="Unlicense"

KEYWORDS="amd64 x86"
SLOT="0"
RDEPEND="xfce-base/thunar"

S="${WORKDIR}"

src_install() {
	dosym ./thunar /usr/bin/thu
}
