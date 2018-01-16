# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
EAUTORECONF=yes
inherit eutils user xfconf

# git clone -b thunarx-2 git://git.xfce.org/thunar-plugins/thunar-shares-plugin

DESCRIPTION="Thunar plugin to share files using Samba"
HOMEPAGE="https://goodies.xfce.org/projects/thunar-plugins/thunar-shares-plugin"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="debug samba"

RDEPEND=">=dev-libs/glib-2.18
	samba? ( net-fs/samba )
	>=x11-libs/gtk+-2.12:2
	>=xfce-base/thunar-1.2"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-static
		$(xfconf_use_debug)
	)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
	if use samba; then
		enewgroup sambashare
		DOCS+=( "${FILESDIR}"/smb.conf.example )
	fi
}

src_prepare() {
	# https://bugzilla.xfce.org/show_bug.cgi?id=10032
	sed -i -e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.in || die
	xfconf_src_prepare
}

src_install() {
	if use samba; then
		keepdir "/var/lib/samba/usershares"
		fowners root:sambashare "/var/lib/samba/usershares"
		fperms 01770 "/var/lib/samba/usershares"
	fi
	xfconf_src_install
}

pkg_postinst() {
	if use samba; then
		ewarn "Just run 'gpasswd -a <USER> sambashare', then have <USER> re-login"
		ewarn "and update your /etc/samba/smb.conf"
		ewarn
		ewarn "   [global]"
		ewarn "       workgroup = WORKGROUP"
		ewarn "       security = share"
		ewarn "       usershare path = /var/lib/samba/usershares"
		ewarn "       usershare max shares = 100"
		ewarn "       usershare allow guests = yes"
		ewarn "       usershare owner only = yes"
		ewarn
	fi

	xfconf_pkg_postinst
}
