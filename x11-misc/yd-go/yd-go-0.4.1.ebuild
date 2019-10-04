# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/slytomcat/yd-go"
EGO_VENDOR=(
	"github.com/cratonica/2goarray 5145107"
	"github.com/fsnotify/fsnotify v1.4.7"
	"github.com/slytomcat/confjson fc25809"
	"github.com/slytomcat/llog ef10956"
	"github.com/slytomcat/systray 6a5d57e"
	"github.com/slytomcat/yandex-disk-simulator 4b3395d"
	"github.com/slytomcat/ydisk 18d7bea"
)

inherit desktop golang-vcs-snapshot xdg-utils

DESCRIPTION="GTK+ version of panel indicator for Yandex-disk CLI daemon"
HOMEPAGE="https://github.com/slytomcat/yd-go"

SRC_URI="https://github.com/slytomcat/yd-go/archive/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
IUSE=""
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-go/go-text:=
	dev-go/go-net:=
	dev-go/go-crypto:=
	dev-go/go-tools:=
	dev-go/go-sys:=
	>=dev-lang/go-1.12"

src_compile() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-s -w" ./... "${EGO_PN}" || die
}

src_install() {
	GOPATH="${S}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-s -w" ./... "${EGO_PN}" || die

	insinto "/usr/share/pixmaps"
	newins "src/${EGO_PN}/icons/icon_files/yd128.png" ${PN}.png

	dodoc "src/${EGO_PN}"/README.md

	dobin bin/${PN}
	make_desktop_entry $PN \
		"Yandex.Disk indicator" \
		$PN "Network"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
