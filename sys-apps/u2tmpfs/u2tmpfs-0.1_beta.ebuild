# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils linux-info

DESCRIPTION="Simple script daemon for automount target user homedir to tmpfs"
HOMEPAGE="https://github.com/linxon/u2tmpfs"
LICENSE="GPL-3"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linxon/u2tmpfs"
else
	SRC_URI="https://github.com/linxon/u2tmpfs/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-shells/bash"

src_prepare() {
	eapply "${FILESDIR}"/fix-skipping-while-updating.patch
	default
}

pkg_setup() {
	local CONFIG_CHECK="~TMPFS"
	local WARNING_TMPFS="CONFIG_TMPFS is required for u2tmpfs support."
	check_extra_config
}

src_install() {
	keepdir /var/lib/${PN}
	fperms 750 /var/lib/${PN}

	newinitd "${FILESDIR}"/u2tmpfs.initd ${PN}
	newconfd "${FILESDIR}"/u2tmpfs.confd ${PN}

	dosbin ${PN}
}

pkg_postinst() {
	ewarn
	ewarn "NOTE: Please, see configuration file: /etc/conf.d/${PN}"
	ewarn ""
	ewarn "You need add USERS and run command:"
	ewarn "rc-update add ${PN} boot && rc-service ${PN} {update,start}"
	ewarn
}
