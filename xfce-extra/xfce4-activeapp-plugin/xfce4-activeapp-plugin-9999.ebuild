# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Active application plugin for the Xfce panel"
HOMEPAGE="https://github.com/adlocode/xfce4-activeapp-plugin"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/adlocode/xfce4-activeapp-plugin"
else
	SRC_URI="https://github.com/adlocode/xfce4-activeapp-plugin/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2+"
SLOT="0"

CDEPEND="
	>=xfce-base/xfce4-panel-4.12.0
"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

src_prepare() {
	./autogen.sh || die "autogen failed" 
	eapply_user
}

src_configure() {
	return
}
