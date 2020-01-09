# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 linux-info toolchain-funcs

DESCRIPTION="Simple tool for forwarding mouse and keyboard input over a TCP connection"
HOMEPAGE="https://github.com/ingemaradahl/remote-input"

EGIT_REPO_URI="https://github.com/ingemaradahl/remote-input"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="f1e41e69368039d25062428c66354b11da87af87"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+daemon test"
RESTRICT="!test? ( test )"

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( dev-libs/check )"

pkg_setup() {
	local CONFIG_CHECK="~INPUT_UINPUT"
	local WARNING_INPUT_UINPUT="CONFIG_INPUT_UINPUT is required for remote-input support."
	check_extra_config
}

src_prepare() {
	sed -e "s/CPPFLAGS/CXXFLAGS/g" \
		-e "/-Wall \\\/d;/-Werror \\\/d" \
		-i Makefile || die

	default
}

src_compile() {
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

src_test() {
	emake CC="$(tc-getCC)" test
}

pkg_postinst() {
	einfo "\nUsage:"
	einfo "  COM1(192.168.1.2) ~# rc-service remote-inputd start"
	einfo "  COM2(192.168.1.3) ~$ forward_input 192.168.1.2\n"
}
