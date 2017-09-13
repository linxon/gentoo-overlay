# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="This tool can, so far, given a serial port connected to a device with brnboot/amazonboot, dump its flash into a file."
HOMEPAGE="https://github.com/rvalles/brntool"
LICENSE="GPL-3"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rvalles/brntool"
else
	SRC_URI="https://github.com/rvalles/brntool/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
RDEPEND="dev-python/pyserial"

src_install() {
	exeinto /usr/share/${PN}/
	doexe ${PN}.py ${PN}.py
	dosym /usr/share/${PN}/${PN}.py /usr/bin/${PN}

	dodoc README.md
}
