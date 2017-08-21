# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit xdg distutils-r1

DESCRIPTION="Offline RSS reader"
HOMEPAGE="https://github.com/bidossessi/brss"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bidossessi/brss"
else
	SRC_URI="https://github.com/bidossessi/brss/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

PLOCALES="fr en"

LICENSE="GPL-2"
SLOT="0"
DEPEND=""
RDEPEND="${DEPEND}
	>=x11-libs/libnotify-0.7.6-r3
	>=dev-python/dbus-python-1.2.0-r1
	x11-libs/gtk+:3
	net-libs/webkit-gtk:3
	dev-libs/glib
	dev-python/pygobject
	dev-python/feedparser
	sys-devel/gettext
"
