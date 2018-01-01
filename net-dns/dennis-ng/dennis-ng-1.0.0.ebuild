# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils systemd

DESCRIPTION="A Dennis-NG TCP DNS Proxy"
HOMEPAGE="https://github.com/BaloneyGeek/dennisng"
SRC_URI="https://github.com/BaloneyGeek/dennisng/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
RESTRICT="mirror"
SLOT="0"
IUSE="systemd"
RDEPEND="dev-qt/qtcore:5"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN//-}-${PV}

src_prepare() {
	default

	# Fix: ACCESS DENIED: open_wr
	sed -i \
		-e "s:target.path = /usr/bin:target.path = ${D}usr/sbin:" \
		-e "s/^INSTALLS += \(config\|systemd\)\$//" \
		dennisng.pro || die "sed failed!"

	# Update config path
	sed -i \
		-e "s:QStringLiteral(\"/etc/dennis.json\"):QStringLiteral(\"/etc/${PN}/dennis.json\"):" \
		Sources/Main.cpp || die "sed failed!"
}

src_configure() {
	# Author comment: The original Dennis was coded using pure C++11 and was simply a quick proxy; 
	# NG is a re-write using Qt5 and intends to be a full-blown DNS 
	# cache some day, probably natively supporting DNSCrypt
	eqmake5
}

src_install() {
	emake install

	newinitd "${FILESDIR}"/dennisd.initd dennisd
	use systemd && systemd_dounit ConfigFiles/dennis.service

	insinto /etc/${PN}
	doins ConfigFiles/dennis.json

	dodoc README.md
}
