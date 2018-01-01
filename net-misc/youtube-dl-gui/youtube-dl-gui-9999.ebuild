# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 gnome2-utils xdg-utils

DESCRIPTION="A cross platform front-end GUI of the popular youtube-dl"
HOMEPAGE="https://mrs0m30n3.github.io/youtube-dl-gui/"
LICENSE="Unlicense"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MrS0m30n3/youtube-dl-gui"
else
	SRC_URI="https://github.com/MrS0m30n3/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
IUSE="+ffmpeg"
SLOT="0"

DEPEND="sys-devel/gettext"
RDEPEND="
	dev-python/wxpython:3.0[${PYTHON_USEDEP}]
	dev-python/twodict
	net-misc/youtube-dl
	ffmpeg? ( media-video/ffmpeg )"

python_install_all() {
	distutils-r1_python_install_all

	make_desktop_entry \
		"${PN}" \
		"Youtube-DLG" \
		"youtube-dl-gui" \
		"Network;GTK;" \
		"StartupNotify=true"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
