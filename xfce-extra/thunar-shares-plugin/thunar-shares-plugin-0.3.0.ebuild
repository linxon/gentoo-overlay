# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit user

DESCRIPTION="Thunar plugin to share files using Samba"
HOMEPAGE="https://goodies.xfce.org/projects/thunar-plugins/thunar-shares-plugin"
SRC_URI="https://archive.xfce.org/src/thunar-plugins/thunar-shares-plugin/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.18
	net-fs/samba
	>=x11-libs/gtk+-3.22:3
	>=xfce-base/thunar-1.7:="
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	enewgroup sambashare
}

src_install() {
	default

	keepdir "/var/lib/samba/usershares"
	fowners root:sambashare "/var/lib/samba/usershares"
	fperms 01770 "/var/lib/samba/usershares"

	find "${D}" -name '*.la' -delete || die
}

pkg_postinst() {
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
}
