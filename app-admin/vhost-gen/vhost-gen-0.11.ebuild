# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1

DESCRIPTION="Configurable vHost generator for Apache 2.2, Apache 2.4 and Nginx"
HOMEPAGE="https://github.com/devilbox/vhost-gen"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/devilbox/vhost-gen"
else
	SRC_URI="https://github.com/devilbox/vhost-gen/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${PYTHON_DEPS}
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"

src_prepare() {
	[ -f "Makefile" ] && rm -fv Makefile

	sed -i \
		-e "s/vhost_gen.py/${PN}/" \
		-e "s/print('vhost_gen v0.3 (2017-09-30)')/print('${PN} v${PV} (2017-09-30)')/" \
		bin/vhost_gen.py || die "sed failed!"

	eapply_user
}

src_install() {
	insinto /etc/vhost-gen
	doins -r etc/templates etc/conf.yml
	dodoc -r examples README.md

	python_foreach_impl python_doscript bin/vhost_gen.py

	make_wrapper \
		"${PN}" \
		"python2 /usr/bin/vhost_gen.py"
}

pkg_postinst() {
	elog
	elog "See documentation: https://github.com/devilbox/vhost-gen#what-is-all-the-fuzz"
	elog
}
