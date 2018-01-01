# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit libtool

DESCRIPTION="CRUSH is a free, open-source collection of Custom Reporting Utilities for SHell"
HOMEPAGE="https://github.com/google/crush-tools"
LICENSE="Apache-2.0"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/google/crush-tools"
else
	SRC_URI="https://github.com/google/crush-tools/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
SLOT="0"

DEPEND="
	dev-lang/perl
	dev-perl/Date-Calc
	dev-perl/DBI
	dev-libs/libpcre"
RDEPEND="${DEPEND}"

src_prepare() {
	./bootstrap && elibtoolize --patch-only
	default
}
