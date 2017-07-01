# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Simple daemon for extract user files to home directory when a system boot"
HOMEPAGE="https://github.com/linxon/u2tmpfs"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/linxon/u2tmpfs"
	inherit git-r3
else
	SRC_URI="https://github.com/linxon/u2tmpfs/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash
	virtual/awk"

src_install() {
	dosbin ${PN}
}
