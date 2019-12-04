# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils xdg-utils

DESCRIPTION="Downloads albums in bulk"
HOMEPAGE="https://github.com/RipMeApp/ripme"
SRC_URI="https://github.com/RipMeApp/ripme/releases/download/${PV}/ripme.jar -> ${P}.jar"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT=0

DEPEND="app-arch/unzip"
RDEPEND="|| ( virtual/jre virtual/jdk )"

S="${WORKDIR}"

src_unpack() {
	unpack ${A} && cp "${DISTDIR}/${P}.jar" "${WORKDIR}" || die
}

src_install() {
	local inst_dir="/opt/${P}"
	local ex_file="${PN}.jar"

	mv "${P}.jar" "${ex_file}" || die

	insinto "${inst_dir}"
	doins ${ex_file}

	insinto "/usr/share/pixmaps/"
	newins "${WORKDIR}"/icon.png ${PN}.png

	make_wrapper $PN "/usr/bin/java -jar \"${inst_dir}/${ex_file}\""
	make_desktop_entry \
		"/usr/bin/${PN}" \
		"RipMe v${PV}" \
		"${PN}" \
		"Network" \
		"Path=${inst_dir}"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
