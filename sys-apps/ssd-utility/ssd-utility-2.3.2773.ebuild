# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="SSD Utility is complementary management software designed to help you maintain, monitor and tune your OCZ SSD"
HOMEPAGE="https://ocz.com/us/download/ssd-utility"
LICENSE="all-rights-reserved"

MY_PN="SSDUtility"
MY_P="${MY_PN}_${PV}"
SRC_URI="https://ocz.com/download/software/ssd-utility/${PV}/SSDUtility_${PV}.tar.gz"

RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"
SLOT="0"
QA_PRESTRIPPED="/opt/ssd-utility/SSDUtility"

S="${WORKDIR}"/${MY_PN}

src_install() {
	local inst_dir="/opt/${PN}"

	exeinto "${inst_dir}"
	use amd64 && doexe "${S}"/linux64/${MY_PN}
	use x86 && doexe "${S}"/linux32/${MY_PN}

	insinto /usr/share/polkit-1/actions/
	doins "${FILESDIR}"/org.ocz.pkexec.ssdutility.policy

	insinto /usr/share/pixmaps/
	doins "${FILESDIR}"/ssd-utility.png

	make_wrapper "${PN}" "pkexec \"/opt/ssd-utility/SSDUtility\""
	make_desktop_entry \
		"/usr/bin/${PN}" \
		"OCZ SSD Utility" \
		"${PN}"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
