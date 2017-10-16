# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit git-r3 distutils-r1

DESCRIPTION="gymail is a simple python mail notification script"
HOMEPAGE="https://github.com/eayin2/gymail"
LICENSE="GPL-2"

SRC_URI=""
EGIT_REPO_URI="https://github.com/eayin2/gymail"

if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="cb73f4db334ee044063b9921fb882483a7c8e1c3"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
RESTRICT="mirror"
