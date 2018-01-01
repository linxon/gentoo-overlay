# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A simple PolicyKit authentication agent for XFCE "
HOMEPAGE="https://github.com/ncopa/xfce-polkit"
LICENSE="GPL-2+"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ncopa/xfce-polkit"
else
	MY_P="xfce-polkit-${PV}"
	SRC_URI="https://github.com/ncopa/xfce-polkit/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

RESTRICT="mirror"
SLOT="0"

CDEPEND="
	>=xfce-base/libxfce4ui-4.13.0
	>=dev-libs/glib-2.36:2
	sys-auth/polkit"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

src_prepare() {
	default
	eautoreconf --install
}

src_configure() {
	local args=("--libexecdir=/usr/libexec")
	econf ${args[@]}
}
