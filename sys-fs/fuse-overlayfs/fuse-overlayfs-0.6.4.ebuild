# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="FUSE implementation for overlayfs"
HOMEPAGE="https://github.com/containers/fuse-overlayfs"
LICENSE="GPL-3"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/containers/fuse-overlayfs"
else
	SRC_URI="https://github.com/containers/fuse-overlayfs/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

SLOT="0"
IUSE=""

# https://github.com/containers/fuse-overlayfs/issues/8#issuecomment-424735109
DEPEND="sys-fs/fuse:3"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	default
}
