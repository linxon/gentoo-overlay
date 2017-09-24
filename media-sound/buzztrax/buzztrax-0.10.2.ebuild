# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils xdg-utils versionator

DESCRIPTION="Buzztrax is a modular music composer for Linux"
HOMEPAGE="http://buzztrax.org/"
LICENSE="LGPL-2.1"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Buzztrax/buzztrax"
else
	SRC_URI="https://github.com/Buzztrax/buzztrax/releases/download/RELEASE_$(replace_all_version_separators "_")/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
SLOT="0"
IUSE="coverage debug doc nls orc +introspection static-libs"

RDEPEND="
	>=dev-libs/glib-2.36:2
	>=media-libs/gstreamer-1.2:1.0
	dev-libs/libxml2
	gnome-extra/libgsf
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/clutter-gtk[gtk]
	x11-libs/gtk+:3
	doc? ( app-text/scrollkeeper )"

DEPEND="${RDEPEND}
	sys-devel/libtool
	doc? ( dev-util/gtk-doc )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local econfargs=(
		--enable-man \
		--disable-update-mime \
		--disable-update-desktop \
		--disable-update-icon-cache \
		$(use_enable doc gtk-doc gtk-doc-html) \
		$(use_enable orc) \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_enable introspection) \
		$(use_enable static-libs static) \
		$(use_enable coverage)
	)

	addpredict /dev/snd/seq
	econf "${econfargs[@]}" || die "econf failed!"
}

pkg_preinst() {
	gnome2_schemas_savelist
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
}
