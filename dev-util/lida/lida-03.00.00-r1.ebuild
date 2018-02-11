# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils xdg-utils

DESCRIPTION="A interactive ELF disambler"
HOMEPAGE="http://lida.sourceforge.net/"
SRC_URI="mirror://sourceforge/$PN/$P.tgz mirror://sourceforge/bastard/libdisasm-0.16.tgz"
RESTRICT="strip mirror"
LICENSE="GPL-1"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/Tk"

src_prepare() {
	sed -i 's|./lida.pl|lida.pl|g' lida || die 'sed failed'
	sed -i 's|./lida_back|lida_back|g' lida.pl || die 'sed failed'
	sed -i \
		'2a #include <string.h>' backend/i386_invariant.c || die 'sed failed!'

	eapply_user
}

src_compile() {
	cd backend
	cp ../../libdisasm_src-0.16/src/arch/i386/libdisasm/i386.opcode.map .
	gcc -I. -ggdb $CFLAGS libdis.c i386_invariant.c i386.c lida_back.c -o\
	../lida_back || die "compile failed"
}

src_install() {
	dobin lida lida_back lida.pl || die "install failed"
	dodoc README CHANGELOG TODO

	make_desktop_entry \
		"${PN}" \
		"Lida" \
		"" \
		"Development"
}

pkg_postinst() {
	xdg_desktop_database_update
}
