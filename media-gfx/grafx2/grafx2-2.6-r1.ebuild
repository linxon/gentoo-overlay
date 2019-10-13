# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop toolchain-funcs xdg-utils

DESCRIPTION="A bitmap paint program specialized in 256 color drawing."
HOMEPAGE="https://gitlab.com/GrafX2/grafX2"

# get it from  src/Makefile < RECOILVER = (.*)
RECOIL_P="recoil-4.3.1"
SRC_URI="
	https://gitlab.com/GrafX2/grafX2/-/archive/v${PV}/grafX2-v${PV}.tar.gz -> ${P}.tar.gz
	recoil? ( mirror://sourceforge/recoil/${RECOIL_P}.tar.gz )"

# recoil use GPL-2 too
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+lua +recoil truetype"

DEPEND="
	media-libs/freetype
	media-libs/libpng:0
	media-libs/libjpeg-turbo
	media-libs/libsdl
	media-libs/sdl-image
	sys-libs/zlib
	truetype? ( media-libs/sdl-ttf )
	lua? ( >=dev-lang/lua-5.1.0:0 )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/grafX2-v${PV}"

src_unpack() {
	default

	if use recoil; then
		mv "${WORKDIR}/${RECOIL_P}" "${S}/3rdparty" \
			|| die 'failed to install!'
	fi
}

src_prepare() {
	# Cleanup
	rm -f doc/gpl-2.0.txt || die

	sed -e "s/-Wall //" -i src/Makefile || die
	default
}

src_compile() {
	local makeconf=()

	# Do you need a "USE_JOYSTICK=1" and "NOLAYERS=1" options? 
	use lua || makeconf+=( "NOLUA=1" )
	use recoil || makeconf+=( "NORECOIL=1" )
	use truetype || makeconf+=( "NOTTF=1" )

	emake CC="$(tc-getCC)" ${makeconf[@]}
}

src_install() {
	insinto /usr/share
	doins -r share/${PN}

	insinto /usr/share/metainfo/
	doins misc/unix/grafx2.appdata.xml

	insinto /usr/share/icons/hicolor/scalable/apps/
	doins share/icons/grafx2.svg
	insinto /usr/share/pixmaps
	doins misc/unix/grafx2.xpm

	doman misc/unix/grafx2.1
	dodoc -r doc/*

	newbin "bin/${PN}-sdl" $PN

	make_desktop_entry $PN \
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
