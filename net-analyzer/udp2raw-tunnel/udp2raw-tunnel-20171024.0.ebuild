# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A Tunnel which turns UDP Traffic into Encrypted FakeTCP/UDP/ICMP Traffic by using Raw Socket"
HOMEPAGE="https://github.com/wangyu-/udp2raw-tunnel"
LICENSE="MIT"

SRC_URI=""
EGIT_REPO_URI="https://github.com/wangyu-/udp2raw-tunnel"

if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~arm ~mips ~x86"
fi

RESTRICT="mirror"
SLOT="0"
IUSE="debug support_aes"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	# Disable warnings and remove prefix name of exec files
	sed -i \
		-e 's/-std=c++11 -Wall/-std=c++11 -Wall -Wno-unused-result/' \
		-e 's/_\$@//' makefile || die "sed failed!"

	if use debug && use support_aes; then
		# Enable debug with a 'support_aes' flag
		sed -i \
			-e 's/-lrt -static/-lrt -static -ggdb/' \
			-e '/debug2: git_version/,+2 d' makefile || die "sed failed!"
	fi

	eapply_user
}

src_compile() {
	local make_opts=($([ use debug && ! use support_aes ] && echo debug2))

	if use support_aes; then
		make_opts+=(
			$(use amd64 && echo amd64_hw_aes)
			$(use arm && echo arm_asm_aes)
			$(use mips && echo mips24kc_be_asm_aes)
			$(use x86 && echo x86_asm_aes)
		)
	fi

	emake ${make_opts[@]}
}

src_install() {
	local ex_name="${PN%%-tunnel}"

	dodoc -r doc/* README.md example.conf Dockerfile
	dobin ${ex_name}
}

pkg_postinst() {
	elog
	elog "See documentation: https://github.com/wangyu-/udp2raw-tunnel#getting-started"
	elog
}
