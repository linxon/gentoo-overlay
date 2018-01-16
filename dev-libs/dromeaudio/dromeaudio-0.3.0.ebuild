# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
CMAKE_MIN_VERSION="2.4"
BUILD_DIR="${S}"

inherit eutils cmake-utils

DESCRIPTION="A small audio manipulation and playback library that's written in C++"
HOMEPAGE="https://github.com/joshb/DromeAudio"
LICENSE="BSD"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/joshb/DromeAudio"
else
	SRC_URI="https://github.com/joshb/DromeAudio/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~x86"
fi

RESTRICT="mirror"
SLOT="0"
DEPEND=""
RDEPEND="
	media-libs/libsdl
	media-libs/libvorbis
	media-libs/alsa-lib"

S="${WORKDIR}/DromeAudio-${PV}"
