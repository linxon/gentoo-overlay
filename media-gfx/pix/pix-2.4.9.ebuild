# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools gnome2-utils xdg-utils

DESCRIPTION="A image management application"
HOMEPAGE="https://github.com/linuxmint/pix"
SRC_URI="https://github.com/linuxmint/pix/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2+"
SLOT="0"
IUSE="cdr debug +exif gnome-keyring +gstreamer http +jpeg json lcms nls +raw +slideshow +svg tiff test webkit +webp"

RDEPEND="
	dev-libs/glib:2[dbus]
	x11-libs/gtk+:3
	media-libs/libpng:0=
	sys-libs/zlib
	net-libs/libsoup:2.4
	x11-libs/libICE
	x11-libs/libSM
	cdr? ( app-cdr/brasero )
	exif? ( media-gfx/exiv2:=[xmp] )
	gnome-keyring? ( app-crypt/libsecret )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0 )
	http? ( net-libs/libsoup:2.4 )
	jpeg? ( virtual/jpeg:0= )
	json? ( dev-libs/json-glib )
	lcms? ( media-libs/lcms:2 )
	slideshow? (
		media-libs/clutter:1.0
		media-libs/clutter-gtk:1.0 )
	svg? ( gnome-base/librsvg )
	tiff? ( media-libs/tiff:= )
	raw? ( media-libs/libopenraw )
	!raw? ( media-gfx/dcraw )
	webkit? ( net-libs/webkit-gtk:4= )
	webp? ( media-libs/libwebp )"

DEPEND="${RDEPEND}
	app-text/yelp-tools
	dev-util/intltool
	gnome-base/gnome-common
	test? ( ~app-text/docbook-xml-dtd-4.1.2 )"

BDEPEND="
	virtual/pkgconfig
	sys-devel/bison
	sys-devel/flex"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		--disable-libchamplain \
		$(use_enable cdr libbrasero) \
		$(use_enable exif exiv2) \
		$(use_enable gnome-keyring libsecret) \
		$(use_enable gstreamer) \
		$(use_enable http libsoup) \
		$(use_enable jpeg) \
		$(use_enable json libjson-glib) \
 		$(use_enable raw libopenraw) \
		$(use_enable slideshow clutter) \
		$(use_enable svg librsvg) \
		$(use_enable test test-suite) \
		$(use_enable webkit webkit2) \
		$(use_enable webp libwebp) \
		$(use_enable debug) \
		$(use_enable nls)
}

src_install() {
	default
	find "${ED}"/usr/lib* -name '*.la' -delete
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	gnome2_schemas_update
}
