# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools systemd

DESCRIPTION="A fork of Jeroen T. Vermeulen's excellent dynamic swap space manager"
HOMEPAGE="https://github.com/Tookmund/Swapspace"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Tookmund/Swapspace"
else
	MY_P="Swapspace-${PV}"
	SRC_URI="https://github.com/Tookmund/Swapspace/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL"
SLOT="0"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	keepdir /var/lib/${PN}
	fperms 740 /var/lib/${PN}

	newconfd "${FILESDIR}"/swapspace.confd ${PN}
	newinitd "${FILESDIR}"/swapspace.initd ${PN}
	systemd_dounit "${FILESDIR}"/swapspace.service

	insinto /etc
	newins "${FILESDIR}"/swapspace.conf ${PN}.conf

	doman doc/*.8

	dosbin src/swapspace
}
