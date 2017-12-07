# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit meson gnome2-utils xdg-utils python-r1

DESCRIPTION="A modern audio book player for Linux using GTK+ 3"
HOMEPAGE="https://github.com/geigi/cozy"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/geigi/cozy"
	KEYWORDS=""
else
	SRC_URI="https://github.com/geigi/cozy/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}
	>=dev-util/meson-0.40.0
	dev-libs/glib:2
	dev-python/peewee[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
	media-libs/gstreamer:1.0
	>=x11-libs/gtk+-3.22"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e "11d" data/desktop.in || die "sed failed!"

	mv debian/changelog ChangeLog || die
	eapply_user
}

src_install() {
	meson_src_install

	dosym ./com.github.geigi.cozy /usr/bin/cozy
	dodoc ChangeLog
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}
