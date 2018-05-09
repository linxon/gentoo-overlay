# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit xdg-utils gnome2-utils

DESCRIPTION="Downloads albums in bulk"
HOMEPAGE="https://github.com/RipMeApp/ripme"
LICENSE="MIT"
SRC_URI="https://github.com/RipMeApp/ripme/releases/download/${PV}/ripme.jar -> ${P}.jar"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
SLOT="0"

S="${WORKDIR}"

DEPEND=""
RDEPEND="${DEPEND}
	>=virtual/jdk-1.7"

src_unpack() {
	unpack ${A} && cp "${DISTDIR}"/"${P}.jar" "${WORKDIR}" || die
}

src_install() {
	local inst_dir="/opt/${P}"
	local ex_file="${PN}.jar"

	mv ${P}.jar ${ex_file} || die

	insinto "${inst_dir}"
	doins ${ex_file}

	insinto /usr/share/pixmaps/
	newins "${WORKDIR}"/icon.png ${PN}.png

	make_wrapper "${PN}" "/usr/bin/java -jar \"${inst_dir}/${ex_file}\""
	make_desktop_entry \
		"/usr/bin/${PN}" \
		"RipMe" \
		"${PN}" \
		"Network" \
		"Path=${inst_dir}"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
