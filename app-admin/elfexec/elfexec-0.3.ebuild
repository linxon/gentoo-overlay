# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Utility to execute ELF binary directly from stdin pipe"
HOMEPAGE="https://github.com/abbat/elfexec"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/abbat/elfexec"
else
	SRC_URI="https://github.com/abbat/elfexec/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

src_prepare() {
	default

	sed \
		-e "s|CFLAGS   :=\(.*\)|CFLAGS   ?=|" \
		-e "s|CPPFLAGS :=\(.*\)|CPPFLAGS ?=|" \
		-e "s|LDFLAGS  :=\(.*\)|LDFLAGS  ?=|" \
		-i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin elfexec
	dodoc README.md
	doman elfexec.1
}
