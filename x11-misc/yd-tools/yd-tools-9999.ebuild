# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils xdg-utils

DESCRIPTION="Panel indicator (GUI) for YandexDisk CLI client"
HOMEPAGE="https://github.com/slytomcat/yandex-disk-indicator"
LICENSE="GPL-3"

MY_PN="yandex-disk-indicator"
MY_P="${MY_PN}-${PV}"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/slytomcat/yandex-disk-indicator"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/slytomcat/yandex-disk-indicator/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	S="${WORKDIR}"/${MY_P}
fi

RESTRICT="mirror"
SLOT="0"
IUSE=""

LINGUAS="be bg el ru"
for X in ${LINGUAS}; do
	IUSE="${IUSE} linguas_${X}"
done

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/pyinotify-0.9.6
	>=dev-libs/glib-2.0:2
	>=x11-libs/gtk+-3.0:3
	>=x11-libs/gdk-pixbuf-2.0:2
	dev-libs/libappindicator:3
	dev-python/pygobject:3
	gnome-extra/zenity
	net-misc/yandex-disk
	x11-misc/xclip"

src_prepare() {
	mv todo.txt TODO || die
	mv build/yd-tools/debian/changelog ChangeLog || die

	# Disable activateActions() on starting
	# because ${PN} freeze while is trying install another filemanagers
	# ¯\_(ツ)_/¯
	epatch "${FILESDIR}"/disable_activateActions.patch
	eapply_user
}

src_install() {
	insinto /usr/share/yd-tools
	doins -r translations icons fm-actions yandex-disk-indicator.py

	exeinto /usr/share/yd-tools
	doexe ya-setup

	for x in ${LINGUAS}; do
		if [[ -f "translations/yandex-disk-indicator_${x}.mo" ]] && use linguas_${x}; then
			insinto /usr/share/locale/${x}/LC_MESSAGES
			newins translations/yandex-disk-indicator_${x}.mo yandex-disk-indicator.mo
		fi
	done

	dodoc README.md TODO ChangeLog man/yd-tools
	domenu Yandex.Disk-indicator.desktop
	doman man/yd-tools.1

	make_wrapper \
		"${MY_PN}" \
		"python3 /usr/share/yd-tools/yandex-disk-indicator.py"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
