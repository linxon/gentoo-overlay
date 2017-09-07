# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker gnome2-utils xdg-utils

DESCRIPTION="3D CAD-CAM application for GNU/Linux"
HOMEPAGE="http://www.gcad3d.org"
LICENSE="GPL-3"

MY_P="gCAD3D-${PV}-bin"
SRC_URI="
        amd64? ( http://www.gcad3d.org/download/${MY_P}-amd64.deb )
        x86? ( http://www.gcad3d.org/download/${MY_P}-i386.deb )"

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
IUSE="-gtk2 +gtk3 doc"
SLOT="0"
REQUIRED_USE="gtk3? ( !gtk2 )"

S="${WORKDIR}"

DEPEND=""
RDEPEND="
	gtk2? ( >=x11-libs/gtk+-2.24.31-r1:2 )
	gtk3? ( >=x11-libs/gtk+-3.12:3 )
	dev-libs/glib
	media-libs/mesa
	gnome-extra/zenity
	virtual/jpeg"

src_prepare() {
	epatch "${FILESDIR}"/update-env.patch
	if use gtk2; then
		epatch "${FILESDIR}"/enable-gtk2.patch
	fi
	eapply_user
}

src_install() {
	local inst_path="/opt/${MY_P%%-bin}"
	local app_name="${PN%%-bin}"

	insinto "${inst_path}"/lib
	doins -r usr/lib/gCAD3D/binLinux*/*

	dodoc -r usr/share/doc/${app_name}/{msg,copyright,changelog.gz}
	if use doc; then
		dodoc -r usr/share/doc/${app_name}/html
	fi

	insinto /usr/share/gcad3d
	doins -r usr/share/gcad3d/*

	insinto /usr/share/pixmaps
	newins usr/share/pixmaps/gCAD3D.xpm gCAD3D.xpm

	exeinto "${inst_path}"
	doexe usr/bin/${app_name}

	dosym "${inst_path}"/${app_name} /opt/bin/${app_name}
	make_desktop_entry "${app_name}" "gCAD3D" "gCAD3D" "GTK;Graphics;" "StartupNotify=true"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
