# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

TPARTY_1_PV="1.1.2"
TPARTY_1_P="QOnlineTranslator-${TPARTY_1_PV}"
TPARTY_2_PV="1.2.2"
TPARTY_2_P="QHotkey-${TPARTY_2_PV}"
TPARTY_3_PV="3.0.13"
TPARTY_3_P="SingleApplication-${TPARTY_3_PV}"

inherit eutils qmake-utils gnome2-utils xdg-utils

DESCRIPTION="A simple translator that allows to translate and say selected text"
HOMEPAGE="https://github.com/Shatur95/crow-translate"

SRC_URI="
	https://github.com/Shatur95/crow-translate/archive/${PV}.tar.gz                -> ${P}.tar.gz
	https://github.com/Shatur95/QOnlineTranslator/archive/${TPARTY_1_PV}.tar.gz    -> ${TPARTY_1_P}.tar.gz
	https://github.com/Skycoder42/QHotkey/archive/${TPARTY_2_PV}.tar.gz            -> ${TPARTY_2_P}.tar.gz
	https://github.com/itay-grudev/SingleApplication/archive/${TPARTY_3_PV}.tar.gz -> ${TPARTY_3_P}.tar.gz"

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtmultimedia:5
	dev-libs/openssl:0
	media-libs/gst-plugins-good:1.0"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}

	mv -f \
		"${WORKDIR}"/${TPARTY_1_P}/* \
		"${WORKDIR}"/${P}/src/qonlinetranslator/ || die
	mv -f \
		"${WORKDIR}"/${TPARTY_2_P}/* \
		"${WORKDIR}"/${P}/src/third-party/qhotkey/ || die
	mv -f \
		"${WORKDIR}"/${TPARTY_3_P}/* \
		"${WORKDIR}"/${P}/src/third-party/singleapplication/ || die
}

src_prepare() {
	eqmake5
	eapply_user
}

src_install() {
	local size

	insinto /usr/share/icons/hicolor/
	doins -r dist/unix/generic/hicolor/scalable
	for size in 16 22 24 32 36 48 64 72 96 128 192 256; do
		doins -r dist/unix/generic/hicolor/${size}x${size}
	done

	dobin crow
	domenu dist/unix/generic/crow-translate.desktop
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
