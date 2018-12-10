# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user autotools

DESCRIPTION="Thunar plugin to share files using Samba"
HOMEPAGE="https://goodies.xfce.org/projects/thunar-plugins/thunar-shares-plugin"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.18
	net-fs/samba
	>=x11-libs/gtk+-2.12:2
	<xfce-base/thunar-1.7"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/xfce4-dev-tools
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS ChangeLog NEWS README TODO "${FILESDIR}"/smb.conf.example )
	enewgroup sambashare
}

src_configure() {
	local myconf=(
		--disable-static
		# workaround the default for git builds
		--enable-debug=minimal
	)
	econf "${myconf[@]}"
}

src_prepare() {
	mv configure.in configure.ac || die
	# https://bugzilla.xfce.org/show_bug.cgi?id=10032
	sed -i \
		-e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' \
		-e 's:-Werror::' \
		configure.ac || die

	local AT_M4DIR="${EPREFIX}/usr/share/xfce4/dev-tools/m4macros"
	eautoreconf

	eapply_user
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
