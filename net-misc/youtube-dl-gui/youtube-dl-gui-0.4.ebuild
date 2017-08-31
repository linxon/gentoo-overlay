# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A cross platform front-end GUI of the popular youtube-dl written in wxPython"
HOMEPAGE="https://github.com/MrS0m30n3/youtube-dl-gui"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MrS0m30n3/youtube-dl-gui"
else
	SRC_URI="https://github.com/MrS0m30n3/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

IUSE="+ffmpeg"
SLOT="0"
DEPEND=""
RDEPEND="${PYTHON_DEPS}
	net-misc/youtube-dl
	dev-python/wxpython:3.0[${PYTHON_USEDEP}]
	ffmpeg? ( media-video/ffmpeg )
"