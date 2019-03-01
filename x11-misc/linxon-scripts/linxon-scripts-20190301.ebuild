# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3

DESCRIPTION="My simple scripts."
HOMEPAGE="http://www.linxon.ru"
SRC_URI=""

EGIT_REPO_URI="https://github.com/linxon/linxon-scripts"
if [[ "${PV}" != *9999 ]]; then
	EGIT_COMMIT="525d2e4404b63f2f50687a78d1322b3495f4b810"
	KEYWORDS="amd64 x86"
fi

RESTRICT="mirror"
LICENSE="Unlicense"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash
	virtual/awk"

src_install() {
	local misc_scr_exec=(
		"mf823"
		"mozilla-addon_get_hash"
		"pwgen_urandom"
		"remove-forever"
		"toggle-conky"
		"toggle-monitor"
		"video-to-gif"
	)

	# misc
	for script in ${misc_scr_exec[@]}; do
		mv -v misc/${script}/${script}.sh ${script} || die
		dobin ${script}
	done
	make_desktop_entry \
		"toggle-monitor" \
		"Enable/Disable monitor" \
		"xfce-display-internal" \
		"System;Settings;"

	# autorun-scriptd
	exeinto /etc/xdg/autorun-script.d
	doexe autorun-scriptd/autorun-script.d/*
	insinto /etc/xdg/autostart/
	doins autorun-scriptd/autorun-scriptd.desktop
	dobin autorun-scriptd/autorun-scriptd.sh

	# dotfiles
	insinto /usr/share
	doins -r dotfiles

	# portage env
	exeinto /etc/portage/repo.postsync.d
	doexe portage/repo.postsync.d/*
}
