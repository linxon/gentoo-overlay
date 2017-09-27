# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="The Convert to FLAC script converts audio files compressed with alternative lossless codecs (Monkey's Audio, Shorten, etc.) to the FLAC format"
HOMEPAGE="https://www.legroom.net/software/convtoflac"
LICENSE="GPL-3"

EGIT_REPO_URI="https://github.com/Thoulah/convtoflac"

RESTRICT="mirror"
SLOT="0"
IUSE="mp4v2 mac shorten ttaenc trash-cli wav"

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

src_prepare() {
	default
	mv ${PN}.sh ${PN}
}

src_install() {
	dobin ${PN}
	dodoc README.md
}

pkg_postinst() {
	elog
	elog "See documentation: https://www.legroom.net/software/convtoflac#usage"
	elog
}
