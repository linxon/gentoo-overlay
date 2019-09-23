# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A simple file manager written in bash"
HOMEPAGE="https://github.com/dylanaraps/fff"

if [[ $PV == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dylanaraps/fff"
else
	SRC_URI="https://github.com/dylanaraps/fff/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	sys-apps/util-linux
	sys-process/procps
	x11-misc/xdotool"

src_compile() {
	:
}

src_install() {
	dobin fff

	doman fff.1
	dodoc README.md
}
