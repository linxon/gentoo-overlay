# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="XFCE4 HotCorner Panel Plugin"
HOMEPAGE="https://github.com/brianhsu/xfce4-hotcorner-plugin"
LICENSE="GPL-2+"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/brianhsu/xfce4-hotcorner-plugin"
else
	SRC_URI="https://github.com/brianhsu/xfce4-hotcorner-plugin/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
DOCS=( AUTHORS README.md )

RDEPEND="
	>=x11-libs/libwnck-3.14.0
	>=xfce-base/libxfce4util-4.10:=
	>=xfce-base/xfce4-panel-4.10:="
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/0.0.2-change_timeout.patch
	cmake-utils_src_prepare
}
