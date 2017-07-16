# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils xdg-utils

MY_P="SSDUtility"

DESCRIPTION="SSD Utility is complementary management software designed to help you maintain, monitor and tune your OCZ SSD"
HOMEPAGE="https://ocz.com/us/download/ssd-utility"
SRC_URI="https://ocz.com/download/software/ssd-utility/${PV}/SSDUtility_${PV}.tar.gz"
KEYWORDS="~amd64 ~x86"
LICENSE="EULA"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_install() {
	local inst_dir="/opt/${PN}"

	exeinto "${inst_dir}"
	if [[ "${ARCH}" == "amd64" ]]; then
		doexe "${S}"/linux64/${MY_P}
	elif [[ "${ARCH}" == "x86" ]]; then
		doexe "${S}"/linux32/${MY_P}
	fi

	insinto /usr/share/polkit-1/actions/
	doins "${FILESDIR}"/org.ocz.pkexec.ssdutility.policy
	dobin "${FILESDIR}"/ssd-utility

	insinto /usr/share/pixmaps/
	newins "${FILESDIR}"/ssd-utility.png ${PN}.png

	make_desktop_entry "/usr/bin/${PN}" "OCZ SSD Utility" "${PN}" "System" "StartupNotify=true"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}