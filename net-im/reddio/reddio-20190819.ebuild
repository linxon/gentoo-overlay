# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="A command-line interface for Reddit written in POSIX sh"
HOMEPAGE="https://gitlab.com/aaronNG/reddio"

EGIT_REPO_URI="https://gitlab.com/aaronNG/reddio"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="66c12ce1911648451221adf8992122138f9fcba8"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	app-misc/jq
	net-misc/curl"

src_prepare() {
	sed -e "s#\${lib_dir:-/usr/local/share/reddio}#\${lib_dir:-/usr/share/reddio}#" \
		-i reddio || die

	default
}

src_compile() {
	:
}

src_install() {
	emake PREFIX="${D}/usr" install
	dodoc README.md ISSUES
}
