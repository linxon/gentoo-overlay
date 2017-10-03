# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A shell daemon that will listen for listening port changes and execute custom commands for each event"
HOMEPAGE="https://github.com/devilbox/watcherp"

SRC_URI=""
EGIT_REPO_URI="https://github.com/devilbox/watcherp"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="cb75394eed17d02661d25966d752413092be3145"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin watcherp
	dodoc README.md
}

pkg_postinst() {
	elog
	elog "Author comment: watcherp will watch for port binding changes (ports started or stopped binding on a network addresss)"
	elog "and will execute specified commands or shell scripts (-a, -d) depending on the event."
	elog "Once all events have happened during one round (-i), a trigger command can be executed (-t)."
	elog "Note, the trigger command will only be execute when at least one add or delete command has succeeded with exit code 0."
	elog
	elog "Examples: https://github.com/devilbox/watcherp#examples"
	elog
}
