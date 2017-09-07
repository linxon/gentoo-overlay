# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 golang-build

DESCRIPTION="Simulating shitty network connections so you can build better systems"
HOMEPAGE="https://github.com/tylertreat/comcast"
LICENSE="Apache-2.0"

SRC_URI=""
EGO_PN="github.com/tylertreat/comcast"
EGIT_REPO_URI="https://github.com/tylertreat/comcast"

if [[ ${PV} != 9999 ]]; then
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
SLOT="0"

RDEPEND=">=dev-lang/go-1.8"
DEPEND="${RDEPEND}"

src_prepare() {
	local _src="${S}"/src/${EGO_PN}

	mkdir -p "${_src}" || die
	cp -R throttler comcast.go "${_src}" || die
	eapply_user
}

src_install() {
	golang-build_src_install

	dobin bin/${PN}
	dodoc README.md LICENSE
}

pkg_postinst() {
	elog
	elog "See documentation: https://github.com/tylertreat/comcast#usage"
	elog
}
