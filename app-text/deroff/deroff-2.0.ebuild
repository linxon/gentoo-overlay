# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Removes roff constructs from documents"
HOMEPAGE="http://www.moria.de/~michael/deroff/"
SRC_URI="http://www.moria.de/~michael/deroff/${P}.tar.gz"
LICENSE="GPL-1"
KEYWORDS="amd64 x86"
RESTRICT="mirror"
SLOT="0"
IUSE=""
LINGUAS="de"

for X in ${LINGUAS}; do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_install() {
	for x in ${LINGUAS}; do
		if [ -f "${x}.mo" ] && use linguas_${x}; then
			insinto /usr/share/locale/${x}/LC_MESSAGES
			newins ${x}.mo ${PN}.mo
			insinto /usr/share/man/${x}/man1/
			newins deroff.1.${x} ${PN}.1
		fi
	done

	insinto /usr/share/man/man1
	newins deroff.1.en ${PN}.1

	dodoc NEWS README
	dobin deroff
}
