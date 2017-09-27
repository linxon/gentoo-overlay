# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit xfconf eutils

DESCRIPTION="A volume control application and panel plug-in for Xfce"
HOMEPAGE="https://git.xfce.org/apps/xfce4-mixer/"
LICENSE="GPL-2"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/xfce-mirror/${PN}"
else
	SRC_URI="https://github.com/xfce-mirror/${PN}/archive/${P}.tar.gz"
	KEYWORDS="amd64 arm ~hppa ~mips ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
	S="${WORKDIR}"/${PN}-${P}
fi

RESTRICT="mirror"
SLOT="0"
IUSE="alsa debug +keybinder oss"

COMMON_DEPEND=">=dev-libs/glib-2.24
	dev-libs/libunique:1
	media-libs/gst-plugins-base:0.10
	>=x11-libs/gtk+-2.20:2
	>=xfce-base/libxfce4ui-4.10
	>=xfce-base/libxfce4util-4.10
	>=xfce-base/xfce4-panel-4.10
	>=xfce-base/xfconf-4.10
	keybinder? ( dev-libs/keybinder:0 )"
RDEPEND="${COMMON_DEPEND}
	alsa? ( media-plugins/gst-plugins-alsa:0.10 )
	oss? ( media-plugins/gst-plugins-oss:0.10 )
	!alsa? ( !oss? ( media-plugins/gst-plugins-meta:0.10 ) )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

src_prepare() {
	./autogen.sh || die "autogen failed"
	epatch "${FILESDIR}"/0001-Fix-broken-dbus-includes-libs_no_autotools.patch
	eapply_user
}

pkg_setup() {
	XFCONF=(
		$(use_enable keybinder)
		$(xfconf_use_debug)
	)

	DOCS=( AUTHORS COPYING NEWS README )
}
