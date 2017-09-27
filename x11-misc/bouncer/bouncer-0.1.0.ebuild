# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Close windows gracefully with a timeout"
HOMEPAGE="https://github.com/TheWebster/bouncer"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/TheWebster/bouncer/archive"
else
	SRC_URI="https://github.com/TheWebster/bouncer/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="BSD"
SLOT="0"
RDEPEND="x11-libs/libxcb"

src_install() {
	dobin bin/bouncer
	dobin bin/bouncer-global

	dodoc VERSION README.md
	doman doc/bouncer.1
}

pkg_postinst() {
	ewarn "NOTE: When leaving X and returning to the console"
	ewarn "most window managers will forcefully destroy all windows still open"
	ewarn "giving you no chance to gracefully close some applications."
	ewarn ""
	ewarn "Usage: bouncer -t 30 -p \"firefox\" && shutdown -h"
}
