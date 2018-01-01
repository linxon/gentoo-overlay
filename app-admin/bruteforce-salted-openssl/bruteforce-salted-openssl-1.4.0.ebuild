# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils autotools

DESCRIPTION="Try to find the password of a file that was encrypted with the 'openssl' command"
HOMEPAGE="https://github.com/glv2/bruteforce-salted-openssl"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/glv2/bruteforce-salted-openssl"
else
	SRC_URI="https://github.com/glv2/bruteforce-salted-openssl/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
DEPEND="dev-libs/openssl:0"
RDEPEND="${DEPEND}"
DOCS=( ChangeLog INSTALL README NEWS AUTHORS )

src_prepare() {
	eautoreconf
	eapply_user
}
