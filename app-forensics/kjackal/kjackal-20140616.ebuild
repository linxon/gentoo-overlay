# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 linux-mod versionator

DESCRIPTION="Linux Rootkit Scanner"
HOMEPAGE="https://github.com/dgoulet/kjackal"
SRC_URI=""

EGIT_REPO_URI="https://github.com/dgoulet/kjackal"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="ad45c330a37ae607144bd0fedad15a1304f2542d"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

RDEPEND=""
DEPEND="${RDEPEND}"

pkg_setup() {
	if use kernel_linux; then
		MODULE_NAMES="${PN}(misc:${S}:${S})"
		BUILD_TARGETS="clean default"

		linux-mod_pkg_setup
	else
		die "Could not determine proper ${PN} package"
	fi
}

src_prepare() {
	if ! version_is_at_least "${KV_FULL}" "3.15"; then
		epatch "${FILESDIR}"/port_to_modern_kernel_api.patch
	fi

	eapply_user
}

src_install() {
	use kernel_linux && linux-mod_src_install
	dodoc README THANKS TODO AUTHORS
}

pkg_postinst() {
	use kernel_linux && linux-mod_pkg_postinst

	elog
	elog "See documentation: https://gitlab.com/nowayout/prochunter/blob/master/README.md#how-to-use"
	elog
}
