# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="A simple multithreaded sshd password bruteforcer using a wordlist"
HOMEPAGE="http://www.edge-security.com"
LICENSE="GPL-2"

SRC_URI="http://www.edge-security.com/soft/${P}.tar"

KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
SLOT="0"
DEPEND=""
RDEPEND="${DEPEND}
	dev-python/pycrypto
	dev-python/paramiko"

S="${WORKDIR}"/${PN}

src_install() {
	insinto /usr/share/${PN}
	doins brutessh.py terminal.py

	make_wrapper "${PN}" "python2 /usr/share/${PN}/brutessh.py"
	dodoc README
}
