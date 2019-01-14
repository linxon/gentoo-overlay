# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils xdg-utils

DESCRIPTION="DroidPad lets you use an Android mobile to control a joystick or mouse."
HOMEPAGE="https://www.digitalsquid.co.uk/droidpad/"
SRC_URI="https://launchpad.net/droidpad-linux/1.0/${PV}/+download/${P}.tar.gz"
KEYWORDS="amd64 ~x86"
LICENSE="GPL-2+"
RESTRICT="mirror"
SLOT="0"
IUSE="nls policykit"

RDEPEND="
	dev-util/android-tools
	dev-libs/openssl:0
	>=dev-cpp/gtkmm-2.8.0:2.4
	policykit? ( sys-auth/polkit )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

src_prepare() {
	if use policykit; then
		sed -e 's/Exec=gksu -D "DroidPad" droidpad/Exec=pkexec droidpad/' \
			-i data/droidpad.desktop.in || die 'sed failed!'
	else
		sed -e 's/Exec=gksu -D "DroidPad" droidpad/Exec=droidpad/' \
			-i data/droidpad.desktop.in || die 'sed failed!'
	fi

	eautoreconf

	eapply "${FILESDIR}"
	eapply_user
}

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	default

	if use policykit; then
		insinto "/usr/share/polkit-1/actions/"
		doins "${FILESDIR}"/uk.co.digitalsquid.pkexec.droidpad.policy
	fi
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
