# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/jesseduffield/lazydocker"

inherit eutils golang-vcs-snapshot

DESCRIPTION="A simple terminal UI for both docker and docker-compose"
HOMEPAGE="https://github.com/jesseduffield/lazydocker"

SRC_URI="https://github.com/jesseduffield/lazydocker/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

BDEPEND="dev-lang/go"
RDEPEND="app-emulation/docker"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-w" "${EGO_PN}" || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-w" "${EGO_PN}" || die

	dobin $PN
	dodoc src/"${EGO_PN}"/{*.md,Dockerfile,docs/{*.md,keybindings/*.md}}
}
