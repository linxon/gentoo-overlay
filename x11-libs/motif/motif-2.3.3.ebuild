# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils flag-o-matic multilib multilib-minimal rpm

DESCRIPTION="Legacy Open Motif libraries for old binaries"
HOMEPAGE="http://motif.ics.com/"

MY_P="openmotif-${PV}"
SRC_URI="http://vault.centos.org/6.9/os/Source/SPackages/${MY_P}-9.el6.src.rpm"

RESTRICT="mirror"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
LICENSE="LGPL-2.1+ MIT"
SLOT="0"
IUSE="jpeg png static-libs unicode"

RDEPEND=">=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXmu-1.1.1-r1[${MULTILIB_USEDEP}]
	>=x11-libs/libXp-1.0.2[${MULTILIB_USEDEP}]
	>=x11-libs/libXt-1.1.4[${MULTILIB_USEDEP}]
	jpeg? ( >=virtual/jpeg-0-r2:0=[${MULTILIB_USEDEP}] )
	png? ( >=media-libs/libpng-1.6.10:0=[${MULTILIB_USEDEP}] )
	unicode? ( >=virtual/libiconv-0-r1[${MULTILIB_USEDEP}] )"

DEPEND="${RDEPEND}
	x11-libs/libXaw
	x11-misc/xbitmaps"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	rpm_src_unpack ${A}
}

src_prepare() {
	eapply "${WORKDIR}"
	eapply_user

	# Build only the libraries
	sed -i -e '/^SUBDIRS/{:x;/\\$/{N;bx;};s/=.*/= lib clients/;}' Makefile.am
	sed -i -e '/^SUBDIRS/{:x;/\\$/{N;bx;};s/=.*/= uil/;}' clients/Makefile.am

	AM_OPTS="--force-missing" eautoreconf

	# get around some LANG problems in make (#15119)
	unset LANG

	# bug #80421
	filter-flags -ftracer

	# feel free to fix properly if you care
	append-flags -fno-strict-aliasing
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		--with-x \
		$(use_enable static-libs static) \
		$(use_enable unicode utf8) \
		$(use_enable jpeg) \
		$(use_enable png)
}

multilib_src_compile() {
	emake -j1
}

multilib_src_install() {
	emake -j1 DESTDIR="${D}" install-exec
}

multilib_src_install_all() {
	# cleanups
	rm -rf "${ED}"/usr/bin
	rm -f "${ED}"/usr/lib*/*.{so,la,a}

	dodoc "${S}"/README "${S}"/RELEASE "${S}"/RELNOTES "${S}"/BUGREPORT "${S}"/TODO
}
