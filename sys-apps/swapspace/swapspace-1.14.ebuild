# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools linux-info systemd

DESCRIPTION="A fork of Jeroen T. Vermeulen's excellent dynamic swap space manager"
HOMEPAGE="https://github.com/Tookmund/Swapspace"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Tookmund/Swapspace"
else
	MY_P="Swapspace-${PV}"
	SRC_URI="https://github.com/Tookmund/Swapspace/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

RDEPEND="sys-libs/glibc"
DEPEND="${RDEPEND}"

LICENSE="GPL-2"
RESTRICT="mirror"
IUSE="systemd"
SLOT="0"

pkg_setup() {
	local CONFIG_CHECK="~SWAP"
	local WARNING_SWAP="CONFIG_SWAP is required for ${PN} support."

	check_extra_config
}

src_prepare() {
	sed -i \
		-e 's:#define ETCPREFIX "/usr/local":#define ETCPREFIX "/":' \
		-e 's:#define VARPREFIX "/usr/local":#define VARPREFIX "/":' \
		src/env.h || die "sed failed!"

	eautoreconf
	eapply_user
}

src_install() {
	keepdir /var/lib/${PN}
	fperms 740 /var/lib/${PN}

	newconfd "${FILESDIR}"/swapspace.confd ${PN}
	newinitd "${FILESDIR}"/swapspace.initd ${PN}
	use systemd && systemd_dounit "${FILESDIR}"/swapspace.service

	insinto /etc
	newins "${FILESDIR}"/swapspace.conf ${PN}.conf

	doman doc/*.8

	dosbin src/swapspace
}
