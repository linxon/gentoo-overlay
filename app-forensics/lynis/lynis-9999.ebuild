# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils bash-completion-r1

DESCRIPTION="Security and system auditing tool"
HOMEPAGE="https://cisofy.com/lynis/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/CISOfy/lynis"
else
	SRC_URI="https://github.com/CISOfy/lynis/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="app-shells/bash"

src_install() {
	doman lynis.8
	dodoc FAQ README
	newdoc CHANGELOG.md CHANGELOG

	# Remove the old one during the next stabilize progress
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/lynis.cron-new lynis

	dobashcomp extras/bash_completion.d/lynis

	# stricter default perms - bug 507436
	diropts -m0700
	insopts -m0600

	insinto /usr/share/${PN}
	doins -r db/ include/ plugins/

	dosbin lynis

	insinto /etc/${PN}
	doins default.prf
}

pkg_postinst() {
	einfo
	einfo "A cron script has been installed to ${ROOT}etc/cron.daily/lynis."
	einfo
}
