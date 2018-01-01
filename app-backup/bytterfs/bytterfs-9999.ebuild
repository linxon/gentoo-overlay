# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Backup script using btrfs send/receive features to incrementally backup via SSH to a remote server"
HOMEPAGE="https://github.com/eayin2/bytterfs"
LICENSE="GPL-3"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/eayin2/bytterfs"
else
	SRC_URI="https://github.com/eayin2/bytterfs/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
RESTRICT="mirror"
DEPEND=""
RDEPEND="${DEPEND}
	sys-fs/btrfs-progs
	net-misc/gymail"
