# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user readme.gentoo-r1 gnome2-utils systemd xdg-utils

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/l-n-s/transmission-i2p"
fi

DESCRIPTION="Anonymous torrent client Transmission-I2P based on 2.82 version"
HOMEPAGE="https://github.com/l-n-s/transmission-i2p"

LICENSE="|| ( GPL-2 GPL-3 Transmission-OpenSSL-exception ) GPL-2 MIT"
SLOT="0"
IUSE="gtk lightweight ayatana systemd nls xfs"

RDEPEND=">=dev-libs/libevent-2.0.10:=
		dev-libs/openssl:0=
		net-libs/libnatpmp:=
		>=net-libs/miniupnpc-1.6.20120509:=
		>=net-misc/curl-7.16.3:=[ssl]
		sys-libs/zlib:=
		gtk? (
			>=dev-libs/dbus-glib-0.100:=
			>=dev-libs/glib-2.32:2=
			>=x11-libs/gtk+-3.4:3=
			ayatana? ( >=dev-libs/libappindicator-0.4.90:3= )
		)
		systemd? ( sys-apps/systemd )"
DEPEND="${RDEPEND}
		dev-libs/glib:2
		dev-util/intltool
		sys-devel/gettext
		virtual/os-headers
		virtual/pkgconfig
		xfs? ( sys-fs/xfsprogs )"

REQUIRED_USE="ayatana? ( gtk )"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	fi
}

src_configure() {

	export ac_cv_header_xfs_xfs_h=$(usex xfs)

	econf --enable-external-natpmp \
			$(use_with gtk) \
			$(use_enable lightweight) \
			$(use_enable nls) \
			$(use_with systemd systemd-daemon)
}

src_compile() {
	emake all || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}"/transmission-daemon.initd.10 transmission-daemon
	newconfd "${FILESDIR}"/transmission-daemon.confd.4 transmission-daemon
	systemd_dounit daemon/transmission-daemon.service
	systemd_install_serviced "${FILESDIR}"/transmission-daemon.service.conf
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update

	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}

	if [[ ! -e "${EROOT%/}"/var/lib/${PN} ]]; then
		mkdir -p "${EROOT%/}"/var/lib/${PN} || die
		chown ${PN}:${PN} "${EROOT%/}"/var/lib/${PN} || die
	fi
}
