# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 linux-mod versionator

DESCRIPTION="A Linux driver for ELAN1200 touchpad"
HOMEPAGE="https://github.com/mishurov/linux_elan1200_touchpad"
SRC_URI=""

EGIT_REPO_URI="https://github.com/mishurov/linux_elan1200_touchpad"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="5c67dee5740f28339d96dd378989dab5d77e96f3"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

pkg_setup() {
	if use kernel_linux; then
		MODULE_NAMES="hid-elan(misc:${S}:${S})"
		BUILD_TARGETS="all"
		BUILD_PARAMS="-j1"

		linux-mod_pkg_setup
	else
		die "Could not determine proper ${PN} package"
	fi
}

src_install() {
	use kernel_linux && linux-mod_src_install
	dodoc README.md
}

pkg_postinst() {
	use kernel_linux && linux-mod_pkg_postinst

	if version_is_at_least "${KV_FULL}" "4.11"; then
		ewarn
		ewarn "Probably this module will not work with the current \"${KV_FULL}\" kernel"
		ewarn
	fi
}
