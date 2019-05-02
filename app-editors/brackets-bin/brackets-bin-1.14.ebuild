# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr
	gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru
	sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW"

inherit chromium-2 eutils git-r3 gnome2-utils pax-utils multilib unpacker xdg-utils

DESCRIPTION="A code editor for HTML, CSS and JavaScript"
HOMEPAGE="http://brackets.io/"

MY_PV="1.14-prerelease-1"
SRC_URI="https://github.com/adobe/brackets/releases/download/release-${MY_PV}/Brackets.Release.${PV/_pre/}.64-bit.deb"
EGIT_DOCS_URI=( "https://github.com/adobe/brackets.wiki.git" )

KEYWORDS="-* ~amd64"
RESTRICT="mirror"
LICENSE="MIT"
IUSE="doc live_preview"
SLOT="0"

RDEPEND="
	!app-editors/brackets
	app-misc/ca-certificates
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	dev-libs/openssl:0=
	gnome-base/gconf
	media-libs/alsa-lib
	media-libs/freetype
	net-misc/wget
	net-misc/curl
	sys-apps/dbus
	virtual/libudev
	x11-libs/gtk+:2
	x11-misc/xdg-utils
	live_preview? (
		|| ( www-client/chromium www-client/google-chrome )
	)"

QA_PREBUILT="*"
S="${WORKDIR}"

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	unpack_deb ${A}

	if use doc; then
		for docs_uri in ${EGIT_DOCS_URI[@]}; do
			git-r3_fetch "${docs_uri}"
			git-r3_checkout "${docs_uri}" "${T}"/docs
		done
	fi
}

src_prepare() {
	local brackets_home="opt/brackets"

	pax-mark m "${brackets_home}/Brackets"

	pushd "${brackets_home}/locales" > /dev/null || die "Failed to install!"
	chromium_remove_language_paks
	popd > /dev/null || die "Failed to install!"

	# Fix: "FATAL:setuid_sandbox_host.cc(162)]
	#       The SUID sandbox helper binary was found, but is not configured correctly"
	chmod 4755 opt/brackets/chrome-sandbox || die "Failed to install!"

	# Cleanup
	rm -rf usr/share/menu usr/share/doc

	default
}

src_install() {
	local my_pn="${PN%%-bin}"
	local s_libs="libnspr4.so.0d libplds4.so.0d libplc4.so.0d libssl3.so.1d \
		libnss3.so.1d libsmime3.so.1d libnssutil3.so.1d libudev.so.1"

	elog "Installing into: /opt/${my_pn} ..."
	cp -Rp . "${D}" || die "Failed to install!"

	# Install symlinks (dev-libs/nss, dev-libs/nspr, dev-libs/openssl, etc...)
	for f in ${s_libs}; do
		target=$(echo ${f} | sed 's/\.[01]d\?$//')
		[ -f "/usr/$(get_abi_LIBDIR)/${target}" ] \
			&& dosym /usr/$(get_abi_LIBDIR)/${target} /opt/${my_pn}/${f} \
			|| die "Failed to install!"
	done

	if use doc; then
		dodoc -r "${T}"/docs
	fi

	make_desktop_entry \
		"${my_pn}" \
		"Brackets" \
		"${my_pn}" \
		"TextEditor;Development;" \
		"MimeType=text/html;\nKeywords=Text;Editor;Write;Web;Development;"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update

	if ! use doc; then
		elog "\nSee documentation: https://github.com/adobe/brackets/wiki\n"
	fi
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
