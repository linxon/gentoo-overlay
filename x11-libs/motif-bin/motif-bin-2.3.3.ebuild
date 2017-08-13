# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit rpm eutils multilib multilib-minimal

DESCRIPTION="The Motif user interface component toolkit"
HOMEPAGE="https://sourceforge.net/projects/motif/
		http://motif.ics.com/"

SRC_URI="amd64? ( ftp://fr2.rpmfind.net/linux/centos/6.9/os/x86_64/Packages/openmotif-${PV}-9.el6.x86_64.rpm )
         x86? ( ftp://fr2.rpmfind.net/linux/centos/6.9/os/i386/Packages/openmotif-${PV}-9.el6.i686.rpm )"

LICENSE="LGPL-2.1+ MIT"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=">=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXmu-1.1.1-r1[${MULTILIB_USEDEP}]
	>=x11-libs/libXp-1.0.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXt-1.1.4[${MULTILIB_USEDEP}]"

DEPEND="${RDEPEND}
	sys-devel/flex
	|| ( dev-util/byacc sys-freebsd/freebsd-ubin )
	x11-misc/xbitmaps"

S="${WORKDIR}"

src_unpack() {
    rpm_src_unpack ${A}
}

src_install() {
	cp -R . "${D}"/ || die
}
