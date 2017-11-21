# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN="github.com/kkomelin/insecres"

inherit git-r3 golang-build

DESCRIPTION="A console tool that finds insecure resources on HTTPS sites"
HOMEPAGE="https://github.com/kkomelin/insecres"
SRC_URI=""

EGIT_REPO_URI="https://github.com/kkomelin/insecres"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="565646f90e10eed4acef5710ccad1b7bdc256746"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

DEPEND="${DEPEND}
	>=dev-lang/go-1.8
	dev-go/go-net
	dev-go/go-crypto"

RDEPEND="${DEPEND}"

src_prepare() {
	local _src="${S}"/src/${EGO_PN}

	mkdir -p "${_src}" || die
	cp -R *.go interfaces "${_src}" || die

	default
}

src_install() {
	golang-build_src_install

	dobin bin/${PN}
	dodoc README.md
}

pkg_postinst() {
	elog
	elog "See documentation: https://github.com/kkomelin/insecres#usage"
	elog
}
