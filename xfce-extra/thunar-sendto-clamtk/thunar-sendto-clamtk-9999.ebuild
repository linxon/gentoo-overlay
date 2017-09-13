# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A simple plugin to allow a right-click, context menu scan of files or folders in Thunar"
HOMEPAGE="https://github.com/dave-theunsub/thunar-sendto-clamtk"
LICENSE="GPL-1"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dave-theunsub/thunar-sendto-clamtk"
else
	SRC_URI="https://github.com/dave-theunsub/thunar-sendto-clamtk/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

RESTRICT="mirror"
SLOT="0"
DEPEND=""
RDEPEND="${DEPEND}
	xfce-base/thunar"

src_prepare() {
	default
	unpack "${S}"/thunar-sendto-clamtk.1.gz
}

src_install() {
	insinto /usr/share/Thunar/sendto/
	doins thunar-sendto-clamtk.desktop
	dodoc CHANGES DISCLAIMER LICENSE README
	doman thunar-sendto-clamtk.1
}
