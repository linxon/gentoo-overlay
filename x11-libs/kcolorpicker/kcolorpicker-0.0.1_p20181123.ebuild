# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="A qt based Color Picker with popup menu library."
HOMEPAGE="https://github.com/DamirPorobic/kColorPicker"
SRC_URI=""

EGIT_REPO_URI="https://github.com/DamirPorobic/kColorPicker"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="658d836cb73455ba1a4a4554900c8dfea750e01f"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5[png]
	dev-qt/qttest:5"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)

	cmake-utils_src_configure
}
