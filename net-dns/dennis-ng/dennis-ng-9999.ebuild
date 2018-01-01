# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
CMAKE_MIN_VERSION="3.5.0"

inherit git-r3 cmake-utils systemd

DESCRIPTION="A Dennis-NG TCP DNS Proxy"
HOMEPAGE="https://github.com/BaloneyGeek/dennisng"
EGIT_REPO_URI="https://github.com/BaloneyGeek/dennisng"
LICENSE="Apache-2.0"
RESTRICT="mirror"
SLOT="0"
IUSE="systemd"
RDEPEND="dev-qt/qtcore:5"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	# Fix: ACCESS DENIED: open_wr
	sed -i \
		-e '/add_subdirectory(ConfigFiles)/d' \
		CMakeLists.txt || die "sed failed!"
	sed -i \
		-e 's/dennis-proxy/dennisd/' \
		-e 's:${CMAKE_INSTALL_PREFIX}/bin:${CMAKE_INSTALL_PREFIX}/sbin:' \
		Sources/CMakeLists.txt || die "sed failed!"

	# Update config path
	sed -i \
		-e "s:QStringLiteral(\"/etc/dennis.json\"):QStringLiteral(\"/etc/${PN}/dennis.json\"):" \
		Sources/Main.cpp || die "sed failed!"
}

src_configure() {
	# Author comment: The original Dennis was coded using pure C++11 and was simply a quick proxy; 
	# NG is a re-write using Qt5 and intends to be a full-blown DNS 
	# cache some day, probably natively supporting DNSCrypt
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	newinitd "${FILESDIR}"/dennisd.initd dennisd
	use systemd && systemd_dounit ConfigFiles/dennis.service

	insinto /etc/${PN}
	doins ConfigFiles/dennis.json

	dodoc README.md
}
