# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic git-r3 linux-info toolchain-funcs

DESCRIPTION="Simple tool for forwarding mouse and keyboard input over a TCP connection"
HOMEPAGE="https://github.com/ingemaradahl/remote-input"
SRC_URI=""

EGIT_REPO_URI="https://github.com/ingemaradahl/remote-input"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="738e38b3a6d24067dda4d7b67302eff4164aac0f"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE="+daemon"

RDEPEND="
	dev-libs/libbsd
	sys-libs/glibc
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp"

DEPEND="${RDEPEND}"

pkg_setup() {
	local CONFIG_CHECK="~INPUT_UINPUT"
	local WARNING_INPUT_UINPUT="CONFIG_INPUT_UINPUT is required for remote-input support."
	check_extra_config
}

src_prepare() {
	eapply "${FILESDIR}"/update_makefile.patch
	eapply_user
}

src_compile() {
	filter-ldflags -Wl,-O1 -Wl,--as-needed
	emake CC="$(tc-getCC)" \
		forward_input \
		$(use daemon && echo "remote-inputd")
}

src_install() {
	if use daemon; then
		newinitd "${FILESDIR}"/remote-input.initd remote-inputd
		newconfd "${FILESDIR}"/remote-input.confd remote-inputd

		insinto /etc/logrotate.d/
		newins "${FILESDIR}"/remote-input.logrotated remote-inputd

		dosbin remote-inputd
	fi

	dobin forward_input
	dodoc README.md
}

pkg_postinst() {
	elog
	elog "Usage:"
	elog "  COM1(192.168.1.2) ~# rc-service remote-inputd start"
	elog "  COM2(192.168.1.3) ~$ forward_input 192.168.1.2"
	elog
}
