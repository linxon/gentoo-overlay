# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Utility to grep log between two dates or tail last lines to time ago"
HOMEPAGE="https://github.com/abbat/timegrep"
SRC_URI="https://github.com/abbat/timegrep/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
SLOT="0"

DEPEND="dev-libs/libpcre"
RDEPEND="${DEPEND}"

src_prepare() {
	# do not clean before building
	sed -e "s/\$(NAME): clean /\$(NAME): /" \
		-i Makefile || die

	default
}
