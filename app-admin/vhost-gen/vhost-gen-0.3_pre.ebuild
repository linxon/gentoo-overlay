# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Configurable vHost generator for Apache 2.2, Apache 2.4 and Nginx"
HOMEPAGE="https://github.com/devilbox/vhost-gen"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/devilbox/vhost-gen"
else
	MY_PV="${PV%%_pre}"
	SRC_URI="https://github.com/devilbox/vhost-gen/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${PN}-${MY_PV}
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/python:2.7
	dev-python/future
	dev-python/pyyaml"

src_prepare() {
	default
	[ -f "Makefile" ] && rm -f Makefile

	# Enable gentoo env...
	sed -i \
		-e "s/vhost_gen.py/${PN}/" \
		-e "s/print('vhost_gen v0.3 (2017-09-30)')/print('${PN} v${PV} (2017-09-30)')/" \
		bin/vhost_gen.py || die "sed failed!"
}

src_install() {
	insinto /etc/vhost-gen
	doins -r etc/templates etc/conf.yml
	dodoc -r examples README.md

	exeinto /usr/share/${PN}
	doexe bin/vhost_gen.py

	make_wrapper \
		"${PN}" \
		"python2 /usr/share/${PN}/vhost_gen.py"
}

pkg_postinst() {
	elog
	elog "See documentation: https://github.com/devilbox/vhost-gen#what-is-all-the-fuzz"
	elog
}
