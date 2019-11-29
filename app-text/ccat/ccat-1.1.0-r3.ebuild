# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/jingweno/ccat"

inherit golang-vcs-snapshot

DESCRIPTION="Colorizing \"cat\""
HOMEPAGE="https://github.com/jingweno/ccat"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jingweno/ccat"
else
	SRC_URI="https://github.com/jingweno/ccat/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lang/go"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		go install -v -work -x -ldflags="-w" "${EGO_PN}"
}

src_install() {
	dobin bin/${PN}
	dodoc "src/${EGO_PN}"/README.md
}

pkg_postinst() {
	einfo "\nIt's recommended to alias ccat to cat:"
	einfo "   alias cat=ccat\n"
	einfo "See documentation: https://github.com/jingweno/ccat#usage\n"
}
