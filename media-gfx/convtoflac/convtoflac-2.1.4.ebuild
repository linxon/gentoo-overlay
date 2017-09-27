# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="The Convert to FLAC script converts audio files compressed with alternative lossless codecs (Monkey's Audio, Shorten, etc.) to the FLAC format"
HOMEPAGE="https://www.legroom.net/software/convtoflac"
LICENSE="GPL-3"

SRC_URI="https://www.legroom.net/files/software/${PN}.sh -> ${P}.sh"

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
SLOT="0"
IUSE="mp4v2 mac shorten ttaenc trash-cli wav"

S="${WORKDIR}"

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/flac
	media-video/ffmpeg
	mac? ( media-sound/mac )
	mp4v2? ( media-libs/libmp4v2 )
	shorten? ( media-sound/shorten )
	ttaenc? ( media-sound/ttaenc )
	trash-cli? ( app-misc/trash-cli )
	wav? ( media-sound/wavpack )"

src_unpack() {
	cp -L "${DISTDIR}"/${A} "${WORKDIR}"/${PN} || die
}

src_install() {
	dobin ${PN}
	dodoc "${FILESDIR}"/README.md
}

pkg_postinst() {
	elog
	elog "See documentation: https://www.legroom.net/software/convtoflac#usage"
	elog
}
