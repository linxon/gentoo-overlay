# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="Maintenance tools for overlayfs."
HOMEPAGE="https://github.com/kmxz/overlayfs-tools"
SRC_URI=""

EGIT_REPO_URI="https://github.com/kmxz/overlayfs-tools"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="0d44989f1ab7f2e0f565e58f9aff7a9cffb32cd7"
	KEYWORDS="~amd64 ~arm ~arm64 ~mips ~x86"
fi

RESTRICT="mirror"
LICENSE="WTFPL-2"
SLOT="0"
IUSE=""

RDEPEND="sys-apps/attr"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -e "s/^CFLAGS = /CFLAGS = ${CFLAGS} /" \
		-e "s/^LFLAGS = /LFLAGS = ${LDFLAGS} /" \
		-e "s/^CC = gcc/CC = $(tc-getCC)/" \
		-i makefile || die 'sed failed!'

	eapply_user
}

src_install() {
	dosbin ${PN%%fs-tools}
	dodoc README.md
}

pkg_postinst() {
	ewarn
	ewarn "Warnings / limitations:\n"
	ewarn "    1) Only works for regular files and directories. Do not use it on OverlayFS"
	ewarn "    with device files, socket files, etc...\n"
	ewarn "    2) Hard links may be broken (i.e. resulting in duplicated independent files).\n"
	ewarn "    3) File owner, group and permission bits will be preserved."
	ewarn "    File timestamps, attributes and extended attributes might be lost.\n"
	ewarn "    4) This program only works for OverlayFS with only one lower layer.\n"
	ewarn "    5) It is recommended to have the OverlayFS unmounted before running this program."

	elog
	elog "See documentation: https://github.com/kmxz/overlayfs-tools#overlayfs-tools"
	elog
	elog "Example usage:"
	elog "    ~# overlay diff -l /lower -u /upper"
	elog
}
