# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1 git-r3 gnome2-utils xdg-utils

DESCRIPTION="Widget Factory for testing GTK styles/themes"
HOMEPAGE="https://github.com/Aurora-and-Equinox/PyTWF"
SRC_URI=""

EGIT_REPO_URI="https://github.com/Aurora-and-Equinox/PyTWF"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="aae6bccbb0ee7bcefea383a9b78254c973156b89"
	KEYWORDS="amd64 x86"
fi

LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/pygtk[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"

src_prepare() {
	eapply "${FILESDIR}"
	eapply_user

	mv PyTWF.py ${PN}.py || die
}

src_install() {
	insinto /usr/share/pytwf/
	doins twf.builder

	python_foreach_impl python_doscript ${PN}.py

	make_wrapper "${PN}" "python2 /usr/bin/${PN}.py"
	make_desktop_entry \
		"${PN}" \
		"PyTWF (testing GTK+ themes)" \
		"preferences-desktop-theme" \
		"Utility;Development;GTK;"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
