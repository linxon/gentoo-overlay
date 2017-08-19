# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker gnome2-utils xdg-utils

MY_P="gCAD3D-${PV}-bin"
DESCRIPTION="3D CAD-CAM application for GNU/Linux"
HOMEPAGE="http://www.gcad3d.org"
SRC_URI="
        amd64? ( http://www.gcad3d.org/download/${MY_P}-amd64.deb )
        x86? ( http://www.gcad3d.org/download/${MY_P}-i386.deb )
"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
RESTRICT="mirror strip"
IUSE="+gtk2 gtk3 doc"
S="${WORKDIR}"

DEPEND=""
RDEPEND="
	!gtk3? ( gtk2? ( >=x11-libs/gtk+-2.24.31-r1:2 ) )
	gtk3? ( >=x11-libs/gtk+-3.12:3 )
	>=dev-libs/glib-2.36:2
	media-libs/mesa
	gnome-extra/zenity
	virtual/jpeg
"

src_prepare() {
	epatch "${FILESDIR}"/update-env.patch
	if use gtk3; then
		epatch "${FILESDIR}"/enable-gtk3.patch
	fi
	eapply_user
}

src_install() {
	local arch_c=$(getconf LONG_BIT)
	local inst_path="/opt/${MY_P%%-bin}"
	local app_name="${PN%%-bin}"

	mkdir -p "${D}"/"${inst_path}"/lib
	if [[ "${arch_c}" == "32" ]] || [[ "${arch_c}" == "64" ]]; then
		cp -R usr/lib/gCAD3D/binLinux${arch_c}/* "${D}"/"${inst_path}"/lib
		cp -R usr/share/gcad3d/* "${D}"/"${inst_path}"
	else
		die "This machine is not support!"
	fi

	dodoc -r usr/share/doc/${app_name}/{msg,copyright,changelog.gz}
	if use doc; then
		dodoc -r usr/share/doc/${app_name}/html
	fi

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
