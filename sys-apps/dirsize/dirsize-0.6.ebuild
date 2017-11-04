# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A tool to display the total size of all files in a directory. Does NOT recurse"
HOMEPAGE="http://plasmasturm.org/code/dirsize/"
SRC_URI="http://plasmasturm.org/code/dirsize/${P}.tar.bz2"
KEYWORDS="amd64 x86"
RESTRICT="mirror"
LICENSE="all-rights-reserved"
SLOT="0"
QA_PRESTRIPPED="/usr/bin/dirsize"

DEPEND="sys-libs/glibc"
RDEPEND="${DEPEND}"
