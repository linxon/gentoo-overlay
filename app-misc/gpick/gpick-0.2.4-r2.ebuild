# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit python-r1 scons-utils toolchain-funcs xdg-utils

DESCRIPTION="Advanced color picker written in C++ using GTK+ toolkit"
HOMEPAGE="https://github.com/thezbyg/gpick http://www.gpick.org/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/thezbyg/gpick"
else
	MY_P="${PN}-${PN}-${PV}"
	SRC_URI="https://github.com/thezbyg/gpick/archive/gpick-${PV}.tar.gz"
	KEYWORDS="amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="BSD"
SLOT="0"
IUSE="dbus debug unique"

BDEPEND="<=dev-util/scons-3.1.2[${PYTHON_USEDEP}]"
RDEPEND="
	dev-lang/lua:0
	dev-libs/expat
	dbus? ( dev-libs/dbus-glib )
	unique? ( dev-libs/libunique:1 )
	x11-libs/cairo
	x11-libs/gtk+:2"

DEPEND="${RDEPEND}
	dev-util/lemon"

PATCHES=(
	"${FILESDIR}/${P}-update-SConscript.patch"
	"${FILESDIR}/${P}-fix_revision-r1.patch"
)

pkg_setup() {
	python_setup
}

src_compile() {
	local myscons=(
		CC="$(tc-getCC)"
		WITH_UNIQUE=$(usex unique)
		WITH_DBUSGLIB=$(usex dbus)
		DEBUG=$(usex debug)
	)

	escons "${myscons[*]}" build || die
}

src_install() {
	escons DESTDIR="${D}/usr" install || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
