# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils systemd user

DESCRIPTION="Standalone I2P BitTorrent Client written in GO"
HOMEPAGE="https://xd-torrent.github.io/"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/majestrate/XD"
else
	MY_PV="${PV//\_/-}"
	SRC_URI="https://github.com/majestrate/XD/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/XD-${MY_PV}"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
IUSE="+webui systemd"

RDEPEND="
	|| ( net-vpn/i2pd net-vpn/i2p )
	systemd? ( sys-apps/systemd )"

DEPEND=">=dev-lang/go-1.8"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
}

src_compile() {
	emake $(use webui && echo "webui" || echo "no-webui")
}

src_install() {
	keepdir /var/lib/${PN}
	fowners -R ${PN}:${PN} /var/lib/${PN}
	fperms 770 /var/lib/${PN}

	newinitd "${FILESDIR}"/xd-torrent.initd ${PN}
	newconfd "${FILESDIR}"/xd-torrent.confd ${PN}
	use systemd && systemd_dounit "${FILESDIR}"/xd-torrent.service

	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/xd-torrent.logrotated ${PN}

	emake PREFIX="${D}"/usr install

	dodoc -r README.md contrib/docker/Dockerfile docs
}

pkg_postinst() {
	ewarn
	ewarn "You need enable the SAM Bridge in /etc/i2pd/i2pd.conf"
	ewarn "and run 'gpasswd -a <USER> ${PN}', then have <USER> re-login."
	elog "See documentation: https://github.com/majestrate/XD#usage"
	elog
}
