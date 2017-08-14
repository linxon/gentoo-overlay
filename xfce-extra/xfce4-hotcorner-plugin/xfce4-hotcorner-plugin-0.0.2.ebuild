# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="XFCE4 HotCorner Panel Plugin"
HOMEPAGE="https://github.com/brianhsu/xfce4-hotcorner-plugin"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/brianhsu/xfce4-hotcorner-plugin"
else
	SRC_URI="https://github.com/brianhsu/xfce4-hotcorner-plugin/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2+"
SLOT="0"

CDEPEND="
	>=x11-libs/libwnck-3.14.0
	>=xfce-base/xfce4-panel-4.12.0
"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"
