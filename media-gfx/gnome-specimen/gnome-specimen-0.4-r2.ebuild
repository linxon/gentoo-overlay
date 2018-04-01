# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7)

inherit autotools gnome2 python-single-r1

DESCRIPTION="Font preview application"
HOMEPAGE="http://uwstopia.nl"
SRC_URI="mirror://debian/pool/main/g/gnome-specimen/gnome-specimen_0.4.orig.tar.gz"
KEYWORDS="amd64 x86"
RESTRICT="mirror"
LICENSE="GPL-2"
IUSE=""
SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/gconf-python[${PYTHON_USEDEP}]
	dev-python/libgnome-python[${PYTHON_USEDEP}]
	dev-python/pygtk[${PYTHON_USEDEP}]
	dev-python/pygobject:2[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}
