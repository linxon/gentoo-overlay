# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake eutils xdg-utils

DESCRIPTION="A Qt/C++ GUI front end to ecryptfs-simple, cryfs, gocryptfs, securefs and encfs"
HOMEPAGE="https://mhogomchungu.github.io/sirikali"
SRC_URI="https://github.com/mhogomchungu/sirikali/archive/${PV}.tar.gz -> ${P}.tar.gz"

# GPL-2+ — *
# src/3rdParty/* — BSD-2
LICENSE="GPL-2+ BSD-2"

KEYWORDS="~amd64 ~arm ~arm64 ~x86"
SLOT=0
IUSE="gnome-keyring kde policykit"

RDEPEND="
	dev-libs/libgcrypt:0=
	dev-libs/libpwquality
	dev-qt/qtcore:5
	dev-qt/qtgui:5[dbus,png,xcb]
	dev-qt/qtnetwork:5[ssl]
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	gnome-keyring? ( app-crypt/libsecret )
	kde? (
		kde-frameworks/kconfig:5
		kde-frameworks/kwallet:5
		kde-frameworks/kwindowsystem:5
	)
	policykit? ( sys-auth/polkit )
	virtual/libffi
	x11-libs/libXau"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( LINUX_BUILD_INSTRUCTIONS changelog README.md )
PATCHES=( "$FILESDIR"/${P}_update_CMakeLists_file-r1.patch )

src_unpack() {
	default

	# Fix QA: One or more compressed files were found in docompress-ed directories
	unpack \
		"${S}/src/sirikali.1.gz" \
		"${S}/src/sirikali.pkexec.1.gz"
}

src_configure() {
	local mycmakeargs=(
		'-DQT5=true'
		'-DINTERNAL_LXQT_WALLET=true'
	)

	use kde || mycmakeargs+=( '-DNOKDESUPPORT=true' )
	use gnome-keyring || mycmakeargs+=( '-DNOSECRETSUPPORT=true' )
	use policykit || mycmakeargs+=( '-DPOLKIT_SUPPORT=false' )

	cmake_src_configure
}

src_install() {
	cmake_src_install

	doman "${WORKDIR}"/sirikali.1
	use policykit \
		&& doman "${WORKDIR}"/sirikali.pkexec.1
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update

	einfo "\nJust install ecryptfs-simple, gocryptfs, securefs if you find it on another overlays\n"

	optfeature "SSHFS support" net-fs/sshfs
	optfeature "EncFS support" sys-fs/encfs
	optfeature "CryFS support" sys-fs/cryfs
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
