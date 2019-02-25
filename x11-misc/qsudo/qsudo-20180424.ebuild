# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 gnome2-utils qmake-utils

DESCRIPTION="GUI for sudo"
HOMEPAGE="https://github.com/sr-tream/qsudo"
SRC_URI=""

EGIT_REPO_URI="https://github.com/sr-tream/qsudo"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="1b8225e50d1f596dafaa59ce3a0692d9db86e861"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5"

DEPEND="${RDEPEND}"

src_prepare() {
	lupdate -no-obsolete "${PN}.pro" || die
	lrelease -compress -removeidentical "${PN}.pro" || die
	eqmake5

	eapply_user
}

src_install() {
	insinto /usr/share/pixmaps/${PN}
	doins {passHide,passShow}.png
	dodoc README.md

	dobin ${PN}
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
