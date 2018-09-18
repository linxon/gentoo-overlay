# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit gnome2-utils

DESCRIPTION="An icon theme mainly based in the Haiku OS look"
HOMEPAGE="https://github.com/mdomlop/retrosmart-icon-theme"
SRC_URI="https://github.com/mdomlop/retrosmart-icon-theme/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
IUSE=""

RDEPEND=""
DEPEND=""

src_prepare() {
	local docs="CREDITS AUTHORS README INSTALL"

	for x in ${docs}; do
		sed -i \
			-e "s:install -Dm 644 ${x} \$(DESTDIR)/\$(PREFIX)/share/doc/\$(NAME)/${x}::" \
			makefile.mk || die "sed failed!"
	done

	sed -i \
		-e "s:install -Dm 644 COPYING \$(DESTDIR)/\$(PREFIX)/share/licenses/\$(NAME)/COPYING::" \
		makefile.mk || die "sed failed!"

	eapply_user
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
