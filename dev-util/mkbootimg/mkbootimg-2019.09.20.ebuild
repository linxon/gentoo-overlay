# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Android bootimg creation tool"
HOMEPAGE="https://github.com/osm0sis/mkbootimg"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/osm0sis/mkbootimg"
else
	SRC_URI="https://github.com/osm0sis/mkbootimg/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

IUSE="static"
LICENSE="Apache-2.0"
SLOT="0"

src_prepare() {
	sed -e 's/^CFLAGS =/CFLAGS +=/' \
		-e 's|-s*$||g;s|-O3||g;s|-Werror||g' \
		-i Makefile libmincrypt/Makefile || die

	default
}

src_compile() {
	emake CC="$(tc-getCC)" $(usev static)
}

src_install() {
	dobin unpackbootimg mkbootimg
	dodoc NOTICE
}
