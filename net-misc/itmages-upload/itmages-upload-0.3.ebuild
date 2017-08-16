# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# Thanks for "betagarden" (https://gpo.zugaina.org/Overlays/betagarden/media-gfx/arcad-c1-bin — updated)

EAPI=6

DESCRIPTION="Perl-script to upload images from the command line"
HOMEPAGE="http://itmages.com/info/tools"
SRC_URI="http://itmages.com/misc/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
RDEPEND="dev-lang/perl"

S="${WORKDIR}"

src_install() {
	dobin ${PN}
	dodoc README
}
