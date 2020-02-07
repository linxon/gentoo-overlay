# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

RECOIL_P="recoil-5.0.0"

FONT8X8_HASH_COMMIT="8e279d2d864e79128e96188a6b9526cfa3fbfef9"
FONT8X8_P="font8x8-${FONT8X8_HASH_COMMIT}"

REDCODE6502_PN="6502"
REDCODE6502_PV="v0.1"
REDCODE6502_P="${REDCODE6502_PN}-${REDCODE6502_PV}"

inherit desktop toolchain-funcs xdg-utils

DESCRIPTION="A bitmap paint program specialized in 256 color drawing"
HOMEPAGE="https://gitlab.com/GrafX2/grafX2"

SRC_URI="
	https://gitlab.com/GrafX2/grafX2/-/archive/v${PV}/grafX2-v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/dhepper/font8x8/archive/${FONT8X8_HASH_COMMIT}.tar.gz -> ${FONT8X8_P}.tar.gz
	https://github.com/redcode/6502/releases/download/${REDCODE6502_PV}/${REDCODE6502_P}.tar.xz
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
	mv "${WORKDIR}/${REDCODE6502_PN}" "${S}/3rdparty" || die
	mv "${WORKDIR}/${FONT8X8_P}"/* "${S}/tools/8x8fonts/font8x8/" || die
}

src_prepare() {
	pushd "3rdparty/${REDCODE6502_PN}" >/dev/null || die
	eapply "${S}/3rdparty/${REDCODE6502_PN}-illegal-opcode.patch"
	popd >/dev/null || die

	# cleanup
	rm -f doc/gpl-2.0.txt || die

	sed -e "s/-Wall //g" -i src/Makefile || die
	default
}

src_compile() {
	local makeargs=(
		CC=$(tc-getCC)
		USE_JOYSTICK=$(usex joystick '0' '1')
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
	dodoc -r *.md doc/*.{txt,rtf} doc/original_docs/

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
