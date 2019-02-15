# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
CMAKE_BUILD_TYPE="release"

inherit cmake-utils

DESCRIPTION="An ncurses mixer for PulseAudio inspired by pavucontrol."
HOMEPAGE="https://github.com/fulhax/ncpamixer"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fulhax/ncpamixer"
else
	SRC_URI="https://github.com/fulhax/ncpamixer/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	media-sound/pulseaudio
	sys-libs/ncurses:0[unicode]"

DEPEND="${RDEPEND}"

S="${S}/src"

src_install() {
	cmake-utils_src_install

	dodoc ../README.md
}
