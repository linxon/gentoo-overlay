# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A simple plugin to allow a right-click, context menu scan of files or folders in the Nemo"
HOMEPAGE="https://github.com/dave-theunsub/nemo-sendto-clamtk"
SRC_URI=""

EGIT_REPO_URI="https://github.com/dave-theunsub/nemo-sendto-clamtk"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="0839fcd1244016b1d590ba2bf4a4dbf9eb68deb4"
	KEYWORDS="amd64 x86"
fi

LICENSE="GPL-1"
RESTRICT="mirror"
SLOT="0"
DEPEND=""
RDEPEND="${DEPEND}
	gnome-extra/nemo"

src_prepare() {
	default
	unpack "${S}"/${PN}.1.gz
}

src_install() {
	insinto /usr/share/nemo/actions/
	doins ${PN}.nemo_action
	dodoc CHANGES DISCLAIMER README.md
	doman ${PN}.1
}
