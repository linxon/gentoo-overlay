# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN="github.com/jingweno/ccat"

inherit golang-vcs-snapshot

DESCRIPTION="Colorizing \"cat\"."
HOMEPAGE="https://github.com/jingweno/ccat"
SRC_URI=""

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

RDEPEND="!app-text/ccat-bin"
DEPEND="${RDEPEND}
	>=dev-lang/go-1.8"

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go install -v -work -x ${EGO_BUILD_FLAGS} "${EGO_PN}"
}

src_install() {
	dobin bin/${PN}
	dodoc src/"${EGO_PN}"/README.md
}

pkg_postinst() {
	elog
	elog "It's recommended to alias ccat to cat:"
	elog "   alias cat=ccat"
	elog
	elog "See documentation: https://github.com/jingweno/ccat#usage"
	elog
}
