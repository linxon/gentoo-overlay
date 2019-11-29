# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="An ncurses mixer for PulseAudio inspired by pavucontrol"
HOMEPAGE="https://github.com/fulhax/ncpamixer"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fulhax/ncpamixer"
else
	SRC_URI="https://github.com/fulhax/ncpamixer/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+wide"

RDEPEND="
	media-sound/pulseaudio
	sys-libs/ncurses:0=[unicode]"

DEPEND="${RDEPEND}"
#BDEPEND="virtual/pkgconfig"

DOCS=( ../README.md )

S="${S}/src"

src_configure() {
	local mycmakeargs=( -DUSE_WIDE="$(usex wide)" ) # https://github.com/fulhax/ncpamixer/issues/25
	cmake-utils_src_configure
}
