# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit git-r3 bash-completion-r1 distutils-r1

DESCRIPTION="Automate & manage your getPocket.com collection"
HOMEPAGE="https://github.com/achembarpu/pockyt"
EGIT_REPO_URI="https://github.com/achembarpu/pockyt"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/parse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
