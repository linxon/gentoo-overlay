# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools gnome2-utils linux-info xdg-utils

DESCRIPTION="A GTK+ utility for computing message digests or checksums"
HOMEPAGE="https://github.com/tristanheaven/gtkhash"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tristanheaven/gtkhash"
else
	SRC_URI="https://github.com/tristanheaven/gtkhash/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="blake2 caja debug +gcrypt +linux-crypto libressl mbedtls nautilus nemo nettle nls +openssl thunar zlib"
REQUIRED_USE="
	openssl? ( !libressl )
	|| ( openssl libressl )"

RDEPEND="
	app-crypt/mhash
	dev-libs/glib:2
	x11-libs/gtk+:3
	blake2? ( app-crypt/libb2 )
	caja? (
		mate-base/caja
		mate-extra/caja-extensions
	)
	gcrypt? ( dev-libs/libgcrypt:0= )
	mbedtls? ( net-libs/mbedtls )
	nautilus? ( gnome-base/nautilus )
	nemo? ( gnome-extra/nemo )
	nettle? ( dev-libs/nettle )
	!libressl? ( openssl? ( >=dev-libs/openssl-1.1:0= ) )
	libressl? ( dev-libs/libressl:0= )
	thunar? ( xfce-base/thunar:= )
	zlib? ( sys-libs/zlib:= )"

DEPEND="${RDEPEND}"

BDEPEND="
	gnome-base/librsvg
	virtual/pkgconfig
	nls? (
		dev-util/intltool
		sys-devel/gettext
	)"

pkg_setup() {
	if use linux-crypto; then
		local CONFIG_CHECK="~CRYPTO_USER_API_HASH"
		local WARNING_CRYPTO_USER_API_HASH="CONFIG_CRYPTO_USER_API_HASH is required for hash algorithm interface"
		check_extra_config
	fi
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local econfargs=(
		--enable-appstream
		--enable-gtkhash
		--enable-glib-checksums
		--enable-internal-md6
		--with-gtk=3.0
		$(use_enable blake2)
		$(use_enable caja)
		$(use_enable debug)
		$(use_enable gcrypt)
		$(use_enable linux-crypto)
		$(use_enable mbedtls)
		$(use_enable nautilus)
		$(use_enable nettle)
		$(use_enable nemo)
		$(use_enable nls)
		$(use_enable openssl libcrypto)
		$(use_enable libressl libcrypto)
		$(use_enable thunar)
		$(use_enable zlib)
	)

	econf "${econfargs[@]}"
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}
