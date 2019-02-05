# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
CMAKE_BUILD_TYPE=RELEASE

inherit cmake-utils eutils gnome2-utils xdg-utils

DESCRIPTION="A Qt/C++ GUI front end to ecryptfs-simple, cryfs, gocryptfs, securefs and encfs."
HOMEPAGE="https://mhogomchungu.github.io/sirikali"
SRC_URI="https://github.com/mhogomchungu/sirikali/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
LICENSE="GPL-2+"
SLOT="0"
IUSE="cryfs +encfs kde +libsecret policykit +sshfs"

RDEPEND="
	libsecret? ( app-crypt/libsecret[crypt,introspection] )
	cryfs? ( sys-fs/cryfs )
	dev-libs/libgcrypt:0=
	dev-libs/libpwquality
	dev-qt/qtcore:5[icu]
	dev-qt/qtgui:5[dbus,png,xcb]
	dev-qt/qtnetwork:5[ssl]
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	encfs? ( sys-fs/encfs )
	kde? (
		kde-frameworks/kconfig:5
		kde-frameworks/kwallet:5
		kde-frameworks/kwindowsystem:5
	)
	policykit? ( sys-auth/polkit )
	sshfs? ( net-fs/sshfs )
	virtual/libffi
	x11-libs/libXau"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( LINUX_BUILD_INSTRUCTIONS changelog README.md )

PATCHES=(
	"$FILESDIR"/update_CMakeLists_file.patch \
	"$FILESDIR"/disable_autoupdate.patch
)

src_unpack() {
	# Fix QA: One or more compressed files were found in docompress-ed directories
	unpack ${A} \
		"${S}/src/sirikali.1.gz" \
		"${S}/src/sirikali.pkexec.1.gz"
}

src_configure() {
	local mycmakeargs=(
		-DQT5=true
		-DINTERNAL_LXQT_WALLET=true
	)

	use kde || mycmakeargs+=( -DNOKDESUPPORT=true )
	use libsecret || mycmakeargs+=( -DNOSECRETSUPPORT=true )
	use policykit || mycmakeargs+=( -DPOLKIT_SUPPORT=false )

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	doman "${WORKDIR}"/sirikali.1
	use policykit && doman "${WORKDIR}"/sirikali.pkexec.1
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update

	elog
	elog "Just install ecryptfs-simple, gocryptfs, securefs if you find it on another overlays"
	elog
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
