# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils git-r3

DESCRIPTION="My simple scripts."
HOMEPAGE="http://www.linxon.ru"
SRC_URI=""

EGIT_REPO_URI="https://github.com/linxon/linxon-scripts"
if [[ "${PV}" != *9999 ]]; then
	EGIT_COMMIT="77b84736469f34d756c1bc8f56126edc0e7346cd"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Unlicense"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	app-shells/bash
	app-admin/stow
	dev-util/ccache
	virtual/awk
	virtual/tmpfiles"

src_install() {
	local misc_scr_exec=(
		"mf823"
		"mozilla-addon_get_hash"
		"pwgen_urandom"
		"remove-forever"
		"toggle-conky"
		"toggle-monitor"
		"video-to-gif"
		"ccache_env"
		"qkernel-params"
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
	exeinto "/etc/xdg/autorun-script.d"
	doexe autorun-scriptd/autorun-script.d/*
	insinto /etc/xdg/autostart/
	doins autorun-scriptd/autorun-scriptd.desktop
	dobin autorun-scriptd/autorun-scriptd.sh

	# dotfiles
	insinto "/usr/share"
	doins -r dotfiles

	# portage env
	for envd in repo.postsync.d postsync.d; do
		exeinto "/etc/portage/${envd}"
		doexe "portage/${envd}"/*
	done
	insinto "/etc/portage"
	doins -r portage/{env,package.env,patches,sets}

	insinto "/etc/tmpfiles.d/"
	doins tmpfilesd/*.conf
}
