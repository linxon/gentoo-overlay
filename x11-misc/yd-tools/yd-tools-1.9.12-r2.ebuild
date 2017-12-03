# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit eutils gnome2-utils xdg-utils python-r1

DESCRIPTION="Panel indicator (GUI) for YandexDisk CLI client"
HOMEPAGE="https://github.com/slytomcat/yandex-disk-indicator"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/slytomcat/yandex-disk-indicator"
else
	MY_P="yandex-disk-indicator-${PV}"
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/slytomcat/yandex-disk-indicator/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	S="${WORKDIR}"/${MY_P}
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
IUSE=""

LINGUAS="be bg el ru"
for X in ${LINGUAS}; do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.0:2
	dev-libs/libappindicator:3
	>=dev-python/pyinotify-0.9.6[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	gnome-extra/zenity
	net-misc/yandex-disk
	x11-misc/xclip
	>=x11-libs/gtk+-3.0:3
	>=x11-libs/gdk-pixbuf-2.0:2"

DEPEND="${RDEPEND}"

src_prepare() {
	mv todo.txt TODO || die
	mv build/yd-tools/debian/changelog ChangeLog || die

	# Change "Exec" path in *.desktop files
	sed -i \
		-e "s:Exec=yandex-disk-indicator:Exec=/usr/bin/yandex-disk-indicator.py:" \
		Yandex.Disk-indicator.desktop || die "sed failed!"

	# Disable activateActions() on starting
	# because ${PN} freeze while is trying install another filemanagers
	# ¯\_(ツ)_/¯
	epatch "${FILESDIR}"/disable_activateActions.patch

	# Fix #181: Change initialization behavior
	# https://github.com/slytomcat/yandex-disk-indicator/issues/181
	epatch "${FILESDIR}"/change_initialization_behavior.patch

	eapply_user
}

src_install() {
	local x

	for x in ${LINGUAS}; do
		if [ -f "translations/yandex-disk-indicator_${x}.mo" ] && use linguas_${x}; then
			insinto /usr/share/locale/${x}/LC_MESSAGES
			newins translations/yandex-disk-indicator_${x}.mo yandex-disk-indicator.mo
		elif ! use linguas_${x}; then
			rm -f translations/{actions-,ya-setup-}${x}.lang
		fi

		rm -f translations/yandex-disk-indicator_${x}.{mo,po}
	done

	insinto /usr/share/yd-tools && exeinto /usr/share/yd-tools
	doins -r translations icons fm-actions
	doexe ya-setup

	dodoc README.md TODO ChangeLog man/yd-tools
	domenu Yandex.Disk-indicator.desktop
	doman man/yd-tools.1

	python_foreach_impl python_doscript yandex-disk-indicator.py

	make_wrapper \
		"yandex-disk-indicator" \
		"python3 /usr/bin/yandex-disk-indicator.py"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
