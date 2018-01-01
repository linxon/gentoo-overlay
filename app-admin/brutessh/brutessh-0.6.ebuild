# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1

DESCRIPTION="A simple multithreaded sshd password bruteforcer using a wordlist"
HOMEPAGE="http://www.edge-security.com"
SRC_URI="http://www.edge-security.com/soft/${P}.tar"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/pycrypto[${PYTHON_USEDEP}]
	dev-python/paramiko"

DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	default

	# Init python package...
	mkdir ${PN} && mv terminal.py ${PN} || die
	echo "from ${PN}.terminal import TerminalController, ProgressBar" > ${PN}/__init__.py || die

	# Add shebang support and change modules...
	sed -i \
		-e "1i #!/usr/bin/python" \
		-e "s/import terminal/from ${PN} import terminal/" ${PN}.py  || die "sed failed!"
}

src_install() {
	dodoc README

	python_foreach_impl python_domodule ${PN}
	python_foreach_impl python_doscript ${PN}.py

	make_wrapper \
		"${PN}" \
		"python2 /usr/bin/${PN}.py"
}
