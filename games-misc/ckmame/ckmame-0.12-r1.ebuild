# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A program to check ROM sets for MAME"
HOMEPAGE="https://nih.at/ckmame/"
SRC_URI="https://nih.at/ckmame/${P}.tar.gz"
RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"
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
	# Fix: https://github.com/linxon/gentoo-overlay/issues/1
	sed -i \
		-e "s/SUBDIRS = docs src regress/SUBDIRS = src regress/" \
		Makefile.in || die "sed failed!"

	eapply_user
}

src_install() {
	default
	dodoc "docs/mame-0.96.dtd" "docs/mess-0.97.dtd"
}
