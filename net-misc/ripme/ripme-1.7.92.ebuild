# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils xdg-utils

DESCRIPTION="Downloads albums in bulk"
HOMEPAGE="https://github.com/RipMeApp/ripme"
SRC_URI="https://github.com/RipMeApp/ripme/releases/download/${PV}/ripme.jar -> ${P}.jar"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

DEPEND="app-arch/unzip"
RDEPEND="|| ( virtual/jre virtual/jdk )"

S="${WORKDIR}"

src_install() {
	local inst_dir="/opt/${P}"
	local ex_file="${PN}.jar"

	insinto "${inst_dir}"
	newins "${DISTDIR}/${P}.jar" $ex_file

	insinto "/usr/share/pixmaps/"
	newins "${WORKDIR}"/icon.png ${PN}.png

	make_wrapper $PN "/usr/bin/java -jar \"${inst_dir}/${ex_file}\""
	make_desktop_entry $PN \
		"RipMe v${PV}" $PN \
		"Network"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
