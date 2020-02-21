# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Find information about the specified imagetag file (BCM63xx)"
HOMEPAGE="https://oldwiki.archive.openwrt.org/doc/techref/brcm63xx.imagetag"
SRC_URI="https://oldwiki.archive.openwrt.org/_media/doc/techref/analyzetag.c"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}"

src_compile() {
	$(tc-getCC) "${DISTDIR}"/analyzetag.c -o analyzetag
}

src_install() {
	dobin analyzetag
}
