# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A shell daemon that will listen for directory changes and execute custom commands for each event"
HOMEPAGE="https://github.com/devilbox/watcherd"

SRC_URI=""
EGIT_REPO_URI="https://github.com/devilbox/watcherd"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="015ebbeef7d8c90a00390c1eebf1c0a627d42e84"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin watcherd
	dodoc README.md
}

pkg_postinst() {
	elog
	elog "Author comment: watcherd will look for directory changes (added and deleted directories) under the specified path (-p)" 
	elog "and will execute specified commands or shell scripts (-a, -d) depending on the event."
	elog "Once all events have happened during one round (-i), a trigger command can be executed (-t)."
	elog "Note, the trigger command will only be execute when at least one add or delete command has succeeded with exit code 0."
	elog
	elog "Examples: https://github.com/devilbox/watcherd#examples"
	elog
}
