# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/GoogleContainerTools/container-diff"

inherit eutils golang-vcs-snapshot

DESCRIPTION="Diff your Docker containers"
HOMEPAGE="https://github.com/GoogleContainerTools/container-diff"

SRC_URI="https://github.com/GoogleContainerTools/container-diff/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

BDEPEND="dev-lang/go"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-s -w" "${EGO_PN}" || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-s -w" "${EGO_PN}" || die

	dobin $PN
	dodoc src/"${EGO_PN}"/*.md
}
