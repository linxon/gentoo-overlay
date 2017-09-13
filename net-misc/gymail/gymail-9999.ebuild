# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="gymail is a simple python mail notification script"
HOMEPAGE="https://github.com/eayin2/gymail"
LICENSE="GPL-2"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/eayin2/gymail"
else
	SRC_URI="https://github.com/eayin2/gymail/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
RESTRICT="mirror"
