# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 eutils

DESCRIPTION="Clearlooks-VK is a GTK+ 3 port of Clearlooks"
HOMEPAGE="https://github.com/linxon/clearlooks-vk"
EGIT_REPO_URI="https://github.com/linxon/clearlooks-vk"
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
