# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Shoot 'em up game where accurate shooting matters (similar Touhou Project)"
HOMEPAGE="http://www.interq.or.jp/libra/oohara/dangen/"
SRC_URI="http://www.interq.or.jp/libra/oohara/dangen/${P}.tar.gz"
RESTRICT="mirror"
KEYWORDS="amd64 x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/sdl-image[png]"

src_install() {
	emake DESTDIR="${D}" install
	make_desktop_entry "${PN}" "Dangen"

	dodoc README README-ja-sjis README-ja-utf8 ChangeLog
}
