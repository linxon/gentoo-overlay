# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils multilib xdg-utils

DESCRIPTION="A screen saver and locker for XFCE."
HOMEPAGE="https://git.xfce.org/apps/xfce4-screensaver/about/"
SRC_URI="https://git.xfce.org/apps/xfce4-screensaver/snapshot/${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="X debug consolekit kernel_linux opengl -pam systemd"

COMMON_DEPEND="
	>=dev-libs/dbus-glib-0.71:0
	>=dev-libs/glib-2.36:2
	gnome-base/dconf:0
	>=sys-apps/dbus-0.30:0
	>=x11-libs/gdk-pixbuf-2.14:2
	>=x11-libs/libX11-1:0
	x11-libs/cairo:0
	>=x11-libs/gtk+-3.22.0
	x11-libs/libXext:0
	x11-libs/libXrandr:0
	x11-libs/libXScrnSaver:0
	x11-libs/libXxf86misc:0
	x11-libs/libXxf86vm:0
	>=x11-libs/libxklavier-5.2:0
	x11-libs/pango:0
	>=xfce-base/libxfce4ui-4.12.1
	>=xfce-base/libxfce4util-4.12.1
	>=xfce-base/xfconf-4.12.1
	>=xfce-base/garcon-0.5.0
	virtual/libintl:0
	consolekit? ( sys-auth/consolekit:0 )
	opengl? ( virtual/opengl:0 )
	pam? ( gnome-base/gnome-keyring:0 virtual/pam:0 )
	!pam? ( kernel_linux? ( sys-apps/shadow:0 ) )
	systemd? ( sys-apps/systemd:0= )
	!!<gnome-extra/gnome-screensaver-3:0
	!!mate-extra/mate-screensaver"

RDEPEND="${COMMON_DEPEND}
	xfce-base/xfce4-session"

DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.50.1:*
	sys-devel/gettext:*
	virtual/pkgconfig:*
	x11-base/xorg-proto"

DOCS=( data/migrate-xscreensaver-config.sh data/xscreensaver-config.xsl )

src_prepare() {
	# Fix: PAM (xfce4-screensaver) illegal module type: @include
	sed -i \
		-e "1d" data/xfce4-screensaver || die "sed failed!"

	eautoreconf
	eapply_user
}

src_configure() {
	local myconf="
		--enable-locking
		--with-kbd-layout-indicator
		--with-mit-ext
		--with-xf86gamma-ext
		--with-xscreensaverdir=/usr/share/xscreensaver/config
		--with-xscreensaverhackdir=/usr/$(get_libdir)/misc/xscreensaver
		$(use_with X x)
		$(use_with consolekit console-kit)
		$(use_with opengl libgl)
		$(use_with systemd)
		$(use_enable debug)
		$(use_enable pam)"

	econf ${myconf}
}

src_install() {
	default

	if ! use pam; then
		fperms u+s /usr/libexec/xfce4-screensaver-dialog
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
