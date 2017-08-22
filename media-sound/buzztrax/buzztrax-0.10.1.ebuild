# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils xdg-utils

DESCRIPTION="Buzztrax is a modular music composer for Linux."
HOMEPAGE="http://buzztrax.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Buzztrax/buzztrax"
else
	MY_PV="RELEASE_0_10_1"
	SRC_URI="https://github.com/Buzztrax/buzztrax/releases/download/${MY_PV}/${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="orc coverage nls debug doc"

CDEPEND="
	>=media-libs/gstreamer-1.2:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	>=dev-libs/glib-2.36:2
	gnome-extra/libgsf
	dev-libs/libxml2
	media-libs/clutter-gtk
	x11-libs/gtk+
	doc? ( dev-util/gtk-doc )"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	local myeconfargs=(
		--enable-man
		--disable-update-mime
		--disable-update-desktop
		--disable-update-icon-cache
		$(use_enable doc gtk-doc)
		$(use_enable orc) \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_enable coverage)
	)

	addpredict /dev/snd/seq
	econf "${myeconfargs[@]}" || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
