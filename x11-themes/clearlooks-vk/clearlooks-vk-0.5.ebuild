# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Clearlooks-VK is a simple GTK theme for XFCE4 and other"
HOMEPAGE="https://github.com/linxon/clearlooks-vk"
SRC_URI="https://github.com/linxon/clearlooks-vk/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 x86"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	>=x11-libs/gtk+-3.14.0:3
	x11-themes/gtk-engines"

src_install() {
	insinto "/usr/share/themes/Clearlooks-VK"
	doins -r *
}
