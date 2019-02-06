# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs versionator

DESCRIPTION="Simple Virtual PC Simulator"
HOMEPAGE="https://github.com/GNS3/vpcs"

MY_PV="$(delete_version_separator '_' ${PV})"
MY_P="${PN}-${MY_PV}"
SRC_URI="https://github.com/GNS3/vpcs/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

RESTRICT="mirror"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}/src/"

src_prepare() {
	# move Makefile in place
	cp Makefile.linux Makefile

	# replace hardcoded CFLAGS with user set CFLAGS
	# append -fno-strict-aliasing to CFLAGS to suppress QA issues from upstream
	# add user $LDFLAGS in the front and remove -s that strips binary
	sed -e "s/-D\$(CPUTYPE)/${CFLAGS} -fno-strict-aliasing/" \
		-e "s/^LDFLAGS=/LDFLAGS=${LDFLAGS} /" \
		-e "s/-s -static//" \
		-i Makefile || die

	rm -fv getopt.h

	eapply_user
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	#put binary in /usr/bin
	dobin vpcs

	doman ../man/vpcs.1
}
