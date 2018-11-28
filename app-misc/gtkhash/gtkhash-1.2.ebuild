# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils linux-info versionator xdg-utils

DESCRIPTION="A GTK+ utility for computing message digests or checksums "
HOMEPAGE="https://github.com/tristanheaven/gtkhash"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tristanheaven/gtkhash"
else
	SRC_URI="https://github.com/tristanheaven/gtkhash/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"

#+openssl
IUSE="caja debug gtk2 +gtk3 +gcrypt static-libs +linux-crypto +mbedtls nautilus nemo nettle nls thunar"

#openssl? ( !mbedtls )
#|| ( openssl mbedtls )
REQUIRED_USE="
	gtk3? ( !gtk2 )
	|| ( gtk3 gtk2 )"

# openssl? ( >=dev-libs/openssl-1.1 ) — in current moment masked. 
# But you can use "mbedtls" flag instead of "openssl"
RDEPEND="
	app-crypt/mhash
	>=dev-libs/glib-2.36:2
	caja? (
		mate-base/caja
		mate-extra/caja-extensions
	)
	!gtk3? ( gtk2? ( >=x11-libs/gtk+-2.24:2 ) )
	gtk3? ( x11-libs/gtk+:3 )
	gcrypt? ( dev-libs/libgcrypt:0 )
	mbedtls? ( net-libs/mbedtls )
	nautilus? ( gnome-base/nautilus )
	nemo? ( gnome-extra/nemo )
	nettle? ( dev-libs/nettle )
	sys-libs/zlib
	thunar? ( xfce-base/thunar )"

DEPEND="${RDEPEND}
	dev-util/intltool
	gnome-base/librsvg
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

_get_thunarx_extension_dir() {
	local extension_dir="/usr/include/thunarx"
	if [ -d "${extension_dir}-2" ]; then echo '2';
	elif [ -d "${extension_dir}-3" ]; then echo '3';
	else die "/usr/include/thunarx-* — is not found!"; fi
}

pkg_setup() {
	if use linux-crypto; then
		local CONFIG_CHECK="~CRYPTO_USER_API_HASH"
		local WARNING_CRYPTO_USER_API_HASH="CONFIG_CRYPTO_USER_API_HASH is required for hash algorithm interface."
		check_extra_config
	fi
}

src_prepare() {
	if use linux-crypto; then
		if version_is_at_least "${KV_FULL}" "2.6.38"; then
			die "\"linux-crypto\" only support in the Linux-2.6.38+ version of kernel."
		fi
	fi

	sed -i \
 		-e "s/thunarx-\${with_thunarx}/thunarx-$(_get_thunarx_extension_dir)/" \
		configure.ac || die 'sed filed!'

	eautoreconf
	eapply_user
}

src_configure() {
	#$(use_enable openssl libcrypto)
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
		$(use_enable nautilus)
		$(use_enable nemo)
		$(use_enable nls)
		$(use_enable static-libs static)
		$(use_enable thunar)
		--enable-zlib
	)

	if use gtk2; then
		econfargs+=( $(use_with gtk2 gtk 2.0) )
	elif use gtk3; then
		econfargs+=( $(use_with gtk3 gtk 3.0) )
	fi

	econf "${econfargs[@]}" || die
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
