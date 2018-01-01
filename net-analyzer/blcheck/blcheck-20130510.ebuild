# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker

DESCRIPTION="DNS Black List - Linux shell script"
HOMEPAGE="https://gist.github.com/agarzon/5554490"
PKG_HASH="ae62700a4edde52a1d2fa303fbfcef613c02860e"
SRC_URI="https://gist.github.com/agarzon/5554490/archive/${PKG_HASH}.zip -> ${P}.zip"
KEYWORDS="amd64 x86"
RESTRICT="mirror"
LICENSE="Unlicense"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	net-dns/bind-tools
	app-shells/bash"

src_unpack() {
	default
	mv "${WORKDIR}"/* ${P} || die
}

src_install() {
	dobin dnsbl.sh
	dosym ./dnsbl.sh /usr/bin/dnsbl
}
