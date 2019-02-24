# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit distutils-r1 git-r3

DESCRIPTION="Get real direct links for files stored in Yandex.Disk."
HOMEPAGE="https://github.com/wldhx/yadisk-direct"
LICENSE="GPL-3"

SRC_URI=""
EGIT_REPO_URI="https://github.com/wldhx/yadisk-direct"

if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
SLOT="0"
RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]"

pkg_postinst() {
	ewarn "While this code depends on an open Yandex's API, I heartily recommend you to not use it in anything resembling production environments"
	elog
	elog "Example: curl -L \$(yadisk-direct https://yadi.sk/i/LKkWupFjr5WzR) -o my_local_filename"
	elog "See documentation: https://github.com/wldhx/yadisk-direct#usage"
	elog
}
