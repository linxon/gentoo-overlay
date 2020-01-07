# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop toolchain-funcs xdg-utils

DESCRIPTION="A bitmap paint program specialized in 256 color drawing"
HOMEPAGE="https://gitlab.com/GrafX2/grafX2"

# get it from  src/Makefile <-- RECOILVER = (.*)
RECOIL_P="recoil-4.3.1"
SRC_URI="
	https://gitlab.com/GrafX2/grafX2/-/archive/v${PV}/grafX2-v${PV}.tar.gz -> ${P}.tar.gz
	mirror://sourceforge/recoil/${RECOIL_P}.tar.gz"

IUSE="doc joystick +lua truetype"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="
	joystick? ( media-libs/libsdl[joystick] )
	media-libs/freetype
	media-libs/libpng:0=
	media-libs/libsdl[X,video]
	media-libs/sdl-image
	media-libs/tiff
	sys-libs/zlib
	truetype? ( media-libs/sdl-ttf )
	lua? ( dev-lang/lua:0 )
	virtual/jpeg"

RDEPEND="${DEPEND}"
BDEPEND="
	doc? ( app-doc/doxygen[dot] )
	virtual/pkgconfig"

S="${WORKDIR}/grafX2-v${PV}"

src_unpack() {
	default
	mv "${WORKDIR}/${RECOIL_P}" "${S}/3rdparty" || die
}

src_prepare() {
	use joystick || eapply "${FILESDIR}/${P}_fix_joystick.patch"

	# cleanup
	rm -f doc/gpl-2.0.txt || die

	sed -e "s/-Wall //g" -i src/Makefile || die
	default
}

src_compile() {
	local makeargs=(
		CC=$(tc-getCC)
		USE_JOYSTICK=$(usex joystick '1' '0')
		NOLUA=$(usex lua '0' '1')
		NOTTF=$(usex truetype '0' '1')
	)

	emake ${makeargs[@]}
}

src_install() {
	insinto /usr/share
	doins -r share/${PN}

	insinto /usr/share/metainfo/
	doins misc/unix/grafx2.appdata.xml

	doicon -s scalable share/icons/grafx2.svg
	insinto /usr/share/pixmaps
	doins misc/unix/grafx2.xpm

	if use doc; then
		emake doc
		dodoc -r doc/doxygen/html
	fi

	doman misc/unix/grafx2.1
	dodoc -r doc/*.txt doc/original_docs/

	dobin "bin/${PN}-sdl"

	make_desktop_entry "${PN}-sdl" \
		"GrafX2" $PN \
		"Graphics;2DGraphics"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
