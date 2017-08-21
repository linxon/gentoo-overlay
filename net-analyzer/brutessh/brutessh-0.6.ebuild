# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A simple multithreaded sshd password bruteforcer using a wordlist"
HOMEPAGE="http://www.edge-security.com"
SRC_URI="${HOMEPAGE}/soft/${P}.tar"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL"
SLOT="0"
RDEPEND="
	dev-python/pycrypto
	dev-python/paramiko
"
S="${WORKDIR}"/${PN}

src_install() {
	exeinto /usr/share/${PN}/
	doexe brutessh.py ${PN}.py
	doexe terminal.py terminal.py

	dobin "${FILESDIR}"/${PN}

	dodoc README LICENSE
}
