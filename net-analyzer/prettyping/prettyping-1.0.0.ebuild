# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Wrapper around the standard ping tool"
HOMEPAGE="http://denilson.sa.nom.br/prettyping/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/denilsonsa/prettyping"
	inherit git-r3
else
	SRC_URI="https://github.com/denilsonsa/prettyping/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="net-misc/iputils
	app-shells/bash
	virtual/awk"

src_install() {
	dodoc README.md

	dobin ${PN}
	dosym ./${PN} /usr/bin/pping
}
