# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit user eutils

DESCRIPTION="Command line pastebin for sharing terminal output"
HOMEPAGE="http://termbin.com"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/solusipse/fiche"
else
	SRC_URI="https://github.com/solusipse/fiche/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="MIT"
SLOT="0"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
}

src_install() {
	keepdir /var/lib/${PN}
	fowners ${PN}:${PN} /var/lib/${PN}
	fperms 740 /var/lib/${PN}

	newinitd "${FILESDIR}"/fiche.initd fiche
	newconfd "${FILESDIR}"/fiche.confd fiche

	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/fiche.logrotated fiche

	dobin ${PN}
}

pkg_postinst() {
	ewarn "NOTE: Please, see configuration file: /etc/conf.d/${PN}"
	ewarn "You need create BASEDIR, configure VirtualHost on web-server"
	ewarn "and add ${PN} to the \"apache\" or \"nginx\" group"
	ewarn "Example: gpasswd -a ${PN} nginx"
	ewarn ""
	ewarn "More information: https://github.com/solusipse/fiche/blob/0.9/README.md"
	ewarn ""
	ewarn "After you can test fiche daemon: rc-service fiche start && cat somefile.txt | nc pastebin.yourdomain.com 9999"
}
