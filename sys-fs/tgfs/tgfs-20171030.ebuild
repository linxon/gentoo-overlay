# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="A telegram attachments in FUSE filesystem"
HOMEPAGE="https://github.com/Firemoon777/tgfs"
SRC_URI=""

EGIT_REPO_URI="https://github.com/Firemoon777/tgfs"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="7950755938466f9a894cd5f1102d9063500e1bb1"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
IUSE=""

RDEPEND="
	sys-libs/zlib
	sys-libs/readline:0=
	dev-libs/libconfig
	dev-libs/openssl:0=
	dev-libs/libevent
	dev-libs/jansson"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	sed -e "s/-Werror //" \
		-e "s/make -C/make ${MAKEOPTS} -C/" \
		-i Makefile.in \
		-i tg/Makefile.in || die 'sed failed!'

	eautoconf
	eapply_user
}

src_install() {
	dobin bin/telegram-tgfs bin/tgfs

	insinto /etc/${PN}
	doins tg/server.pub

	dodoc README.md
}
