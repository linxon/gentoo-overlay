# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools gnome2-utils linux-info xdg-utils

DESCRIPTION="A GTK+ utility for computing message digests or checksums"
HOMEPAGE="https://github.com/tristanheaven/gtkhash"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tristanheaven/gtkhash"
else
	SRC_URI="https://github.com/tristanheaven/gtkhash/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

# TODO: add peony FM support
IUSE="caja debug gtk2 +gtk3 +gcrypt +linux-crypto libressl mbedtls nautilus nemo nettle nls +openssl thunar"
REQUIRED_USE="
	openssl? ( !libressl )
	|| ( openssl libressl )
	gtk3? ( !gtk2 )
	|| ( gtk3 gtk2 )"

RDEPEND="
	app-crypt/mhash
	dev-libs/glib:2
	caja? (
		mate-base/caja
		mate-extra/caja-extensions
	)
	!gtk3? ( gtk2? ( x11-libs/gtk+:2 ) )
	gtk3? ( x11-libs/gtk+:3 )
	gcrypt? ( dev-libs/libgcrypt:0= )
	mbedtls? ( net-libs/mbedtls )
	nautilus? ( gnome-base/nautilus )
	nemo? ( gnome-extra/nemo )
	nettle? ( dev-libs/nettle )
	!libressl? ( openssl? ( >=dev-libs/openssl-1.1:0= ) )
	libressl? ( dev-libs/libressl:0= )
	sys-libs/zlib:=
	thunar? ( xfce-base/thunar )"

DEPEND="${RDEPEND}
	dev-util/intltool
	gnome-base/librsvg
	nls? ( sys-devel/gettext )"

BDEPEND="virtual/pkgconfig"

_get_thunarx_ver() {
	local extension_dir="/usr/include/thunarx"

	if [ -d "${extension_dir}-2" ]
		then echo '2'
	elif [ -d "${extension_dir}-3" ]
		then echo '3'
	else
		die "/usr/include/thunarx-* — is not found!"
	fi
}

pkg_setup() {
	if use linux-crypto; then
		local CONFIG_CHECK="~CRYPTO_USER_API_HASH"
		local WARNING_CRYPTO_USER_API_HASH="CONFIG_CRYPTO_USER_API_HASH is required for hash algorithm interface."
		check_extra_config
	fi
}

src_prepare() {
	sed -e "s/thunarx-\${with_thunarx}/thunarx-$(_get_thunarx_ver)/" \
		-i configure.ac || die 'sed filed!'

	eautoreconf
	default
}

src_configure() {
	local econfargs=(
		--enable-appstream
		--disable-blake2
		$(use_enable caja)
		$(use_enable debug)
		$(use_enable gcrypt)
		--enable-gtkhash
		--enable-glib-checksums
		--enable-internal-md6
		$(use_enable linux-crypto)
		$(use_enable mbedtls)
		$(use_enable nautilus)
		$(use_enable nettle)
		$(use_enable nemo)
		$(use_enable nls)
		$(use_enable openssl libcrypto)
		$(use_enable libressl libcrypto)
		$(use_enable thunar)
		--enable-zlib
	)

	if use gtk2; then
		econfargs+=( $(use_with gtk2 gtk 2.0) )
	elif use gtk3; then
		econfargs+=( $(use_with gtk3 gtk 3.0) )
	fi

	econf "${econfargs[@]}"
}

pkg_preinst() {
	gnome2_schemas_savelist
	gnome2_icon_savelist
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
