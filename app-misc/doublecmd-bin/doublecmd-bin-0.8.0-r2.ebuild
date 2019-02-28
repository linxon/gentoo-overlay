# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="Cross Platform file manager."
HOMEPAGE="http://doublecmd.sourceforge.net/"

MY_PN="${PN%%-bin}"
SRC_URI="
	x86?      ( gtk2? ( mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}.gtk2.i386.tar.xz )
				qt5?  ( mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}.qt5.i386.tar.xz ) )
	amd64?    ( gtk2? ( mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}.gtk2.x86_64.tar.xz )
				qt5?  ( mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}.qt5.x86_64.tar.xz ) )"

RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2"
IUSE="+gtk2 policykit qt5"

REQUIRED_USE="
	gtk2? ( !qt5 )
	|| ( gtk2 qt5 )"

SLOT="0"

DEPEND=""
RDEPEND="
	dev-libs/glib:2
	gtk2? (
		media-libs/libpng
		x11-libs/gtk+:2 )
	policykit? ( sys-auth/polkit )
	qt5? ( dev-qt/qtgui:5 )
	sys-apps/dbus
	x11-libs/libX11"

QA_PREBUILT="
	*/doublecmd
	*/libQt5Pas.so.1"

S="${WORKDIR}"/${MY_PN}

src_prepare() {
	rm -f doc/COPYING.* \
		|| die "failed to install!"

	# no save configs in Program Dir
	sed -e '/<UseConfigInProgramDir>/s/True/False/' \
		-i doublecmd.xml || die "failed to install!"

	eapply_user
}

src_install() {
	local inst_dir="/opt/${P}"

	dodoc -r doc/* && rm -rf doc

	insinto "${inst_dir}" && exeinto "${inst_dir}"
	doins -r .
	doexe doublecmd

	if use policykit; then
		insinto "/usr/share/polkit-1/actions/"
		doins "${FILESDIR}"/org.doublecmd.root.policy
	fi

	dosym \
		"../../../${inst_dir}/doublecmd.png" \
		"/usr/share/pixmaps/${MY_PN}.png"
	dosym \
		"../../../../../../${inst_dir}/pixmaps/mainicon/alt/dcfinal.svg" \
		"/usr/share/icons/hicolor/scalable/apps/${MY_PN}.svg"

	make_wrapper \
		"${MY_PN}" \
		"${inst_dir}/${MY_PN}" \
		"" "${inst_dir}"

	make_desktop_entry \
		"${MY_PN}" \
		"Double Commander (bin)" \
		"${MY_PN}" \
		"Utility;FileTools;FileManager;"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
