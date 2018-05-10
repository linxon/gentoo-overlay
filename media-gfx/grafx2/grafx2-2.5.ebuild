# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils xdg-utils

RECOIL_P="recoil-4.2.0"
DESCRIPTION="The ultimate 256 color painting program"
HOMEPAGE="https://gitlab.com/GrafX2/grafX2"

SRC_URI="
	https://gitlab.com/GrafX2/grafX2/-/archive/v${PV}/grafX2-v${PV}.tar.gz -> ${P}.tar.gz
	recoil? ( mirror://sourceforge/recoil/${RECOIL_P}.tar.gz )"

LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+lua +recoil truetype"

DEPEND="
	media-libs/freetype
	media-libs/libpng:0
	media-libs/libjpeg-turbo
	media-libs/libsdl
	media-libs/sdl-image
	sys-libs/glibc
	sys-libs/zlib
	truetype? ( media-libs/sdl-ttf )
	lua? ( >=dev-lang/lua-5.1.0:0 )"

RDEPEND="${DEPEND}"

S="${WORKDIR}"/grafX2-v${PV}

src_unpack() {
	default

	if use recoil; then
		mv "${WORKDIR}"/${RECOIL_P} "${S}"/3rdparty || die
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}_disable_checking_git_revision.patch
	eapply_user
}

src_compile() {
	local makeconf=()
	use lua || makeconf+=( "NOLUA=1" )
	use recoil || makeconf+=( "NORECOIL=1" )
	use truetype || makeconf+=( "NOTTF=1" )

	emake ${makeconf[@]}
}

src_install() {
	insinto /usr/share
	doins -r share/${PN}

	insinto /usr/share/icons
	doins share/icons/grafx2.svg

	doman misc/unix/grafx2.1
	dodoc CONTRIBUTING.md doc/*
	dobin bin/${PN}

	make_desktop_entry \
		"${PN}" \
		"GrafX2" \
		"${PN}" \
		"Graphics"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
