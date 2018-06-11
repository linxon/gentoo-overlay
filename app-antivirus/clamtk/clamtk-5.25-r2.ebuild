# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PLOCALES="af ar ast az bg bs ca cs da de el_GR en_AU en_CA en_GB eo es eu fi fo \
	fr ga gl he hr hu id it ja km ko lo lt lv mr ms nb nl nl_BE nn pa pl pt pt_BR \
	ro ru si sk sl sr@latin sv ta te th tr ug uk uz zh_CN zh_TW"

inherit eutils perl-module gnome2-utils l10n xdg-utils

DESCRIPTION="A frontend for ClamAV using Gtk2-perl"
HOMEPAGE="https://dave-theunsub.github.io/clamtk/"
SRC_URI="https://bitbucket.org/davem_/clamtk/downloads/${P}.tar.xz"
LICENSE="|| ( Artistic GPL-1+ )"
RESTRICT="mirror userpriv"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nemo nls thunar"

RDEPEND="
	>=app-antivirus/clamav-0.95
	dev-perl/JSON
	dev-perl/LWP-Protocol-https
	dev-perl/Locale-gettext
	dev-perl/Text-CSV
	dev-perl/glib-perl
	dev-perl/Gtk2
	dev-perl/libwww-perl
	nemo? ( gnome-extra/nemo-sendto-clamtk )
	virtual/perl-Digest-SHA
	virtual/perl-MIME-Base64
	virtual/perl-Time-Piece
	thunar? ( xfce-extra/thunar-sendto-clamtk )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}" || die "cd failed"
	gunzip ${PN}.1.gz || die "gunzip failed"
}

src_prepare() {
	l10n_find_plocales_changes "po" "" ".po"
	default
}

src_install() {
	dobin ${PN}

	if use nls; then
		do_loc() { domo "po/${1}.mo"; }
		l10n_for_each_locale_do do_loc
	fi

	doicon images/* || die "doicon failed"
	domenu ${PN}.desktop || die "domenu failed"

	dodoc CHANGES README.md DISCLAIMER
	doman ${PN}.1

	# The custom Perl modules
	perl_set_version
	insinto "${VENDOR_LIB}/ClamTk"
	doins lib/*.pm
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
