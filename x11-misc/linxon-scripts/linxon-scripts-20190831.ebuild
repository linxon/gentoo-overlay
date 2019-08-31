# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils git-r3

DESCRIPTION="My simple scripts."
HOMEPAGE="http://www.linxon.ru"
SRC_URI=""

EGIT_REPO_URI="https://github.com/linxon/linxon-scripts"
if [[ "${PV}" != *9999 ]]; then
	EGIT_COMMIT="ed18918619f8e6098f09cb2fb0ac8f7c5c534618"
	KEYWORDS="~amd64 ~x86"
fi

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
	for envd in repo.postsync.d postsync.d; do
		exeinto "/etc/portage/${envd}"
		doexe "portage/${envd}"/*
	done
	insinto "/etc/portage"
	doins -r portage/{env,package.env,patches,sets,modules,trusted-overlays,make.conf*}
}
