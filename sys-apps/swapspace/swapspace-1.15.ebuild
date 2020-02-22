# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-info systemd

DESCRIPTION="A fork of Jeroen T. Vermeulen's excellent dynamic swap space manager"
HOMEPAGE="https://github.com/Tookmund/Swapspace"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Tookmund/Swapspace"
else
	SRC_URI="https://github.com/Tookmund/Swapspace/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/Swapspace-${PV}"
fi

LICENSE="GPL-2"
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
		src/env.h || die

	eautoreconf
	default
}

src_install() {
	dosbin src/swapspace

	keepdir "/var/lib/${PN}"
	fperms 0750 "/var/lib/${PN}"

	newconfd "${FILESDIR}"/swapspace.confd $PN
	newinitd "${FILESDIR}"/swapspace.initd $PN
	use systemd && systemd_dounit "${FILESDIR}"/swapspace.service

	insinto "/etc"
	newins "${FILESDIR}"/swapspace.conf ${PN}.conf

	doman doc/*.8
	dodoc \
		README.md \
		NEWS INSTALL \
		ChangeLog AUTHORS \
		swapspace.conf
}
