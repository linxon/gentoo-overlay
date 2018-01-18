# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN="github.com/jingweno/ccat"

inherit golang-build

DESCRIPTION="Colorizing \"cat\""
HOMEPAGE="https://github.com/jingweno/ccat"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jingweno/ccat"
else
	SRC_URI="https://github.com/jingweno/ccat/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-lang/go-1.8"

src_prepare() {
	local _src="${S}"/src/${EGO_PN}

	mkdir -p "${_src}" || die
	cp -R *.go Godeps "${_src}" || die

	default
}

src_install() {
	golang-build_src_install

	dobin bin/${PN}
	dodoc README.md
}

pkg_postinst() {
	elog
	elog "It's recommended to alias ccat to cat:"
	elog "alias cat=ccat"
	elog
	elog "See documentation: https://github.com/jingweno/ccat#usage"
	elog
}
