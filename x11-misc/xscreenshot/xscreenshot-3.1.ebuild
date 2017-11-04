# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker gnome2-utils xdg-utils multilib

DESCRIPTION="A tool for capture, edit, share and exchange screenshots between people via the internet"
HOMEPAGE="http://xscreenshot.com"
SRC_URI="http://xscreenshot.com/downloads/${PN}-linux-i386.tar.gz -> ${P}.tar.gz"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86 -*"
RESTRICT="mirror strip"

RDEPEND="
	app-arch/bzip2[abi_x86_32(-)]
	dev-libs/expat[abi_x86_32(-)]
	media-libs/libpng:0[abi_x86_32(-)]
	media-libs/fontconfig[abi_x86_32(-)]
	media-libs/freetype[abi_x86_32(-)]
	sys-libs/zlib[abi_x86_32(-)]
	sys-libs/glibc
	x11-libs/libXrender[abi_x86_32(-)]
	x11-libs/libxcb[abi_x86_32(-)]
	x11-libs/libXau[abi_x86_32(-)]
	x11-libs/libXdmcp[abi_x86_32(-)]
	x11-libs/libXext[abi_x86_32(-)]
	x11-libs/libX11[abi_x86_32(-)]"

DEPEND="${RDEPEND}"

S="${WORKDIR}"

pkg_setup() {
	multilib_toolchain_setup x86
}

src_unpack() {
	default
	tar -x -f "${FILESDIR}"/xscreenshot-icon.png.tar.xz -C "${S}" || die
}

src_install() {
	insinto /usr/share/pixmaps
	doins xscreenshot-icon.png

	dobin ${PN}

	make_desktop_entry \
		"${PN}" \
		"eXtended Screenshot" \
		"xscreenshot-icon" \
		"Utility;"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
