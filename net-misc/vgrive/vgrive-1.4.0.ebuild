# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="A Google Drive client for linux"
HOMEPAGE="https://github.com/bcedu/VGrive"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bcedu/VGrive"
else
	SRC_URI="https://github.com/bcedu/VGrive/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"

	S="${WORKDIR}/VGrive-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

BDEPEND="virtual/pkgconfig"
RDEPEND="
	dev-libs/glib:=
	x11-libs/gtk+:3[introspection]
	dev-libs/granite[introspection]
	dev-libs/libgee:*[introspection]
	dev-libs/json-glib[introspection]
	net-libs/libsoup[introspection]
	$(vala_depend)"

DEPEND="${RDEPEND}"

src_prepare() {
	vala_src_prepare
	default
}

src_install() {
	meson_src_install
	dosym ./com.github.bcedu.vgrive /usr/bin/vgrive
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	gnome2_schemas_update
}
