# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="A qt based library for annotating images."
HOMEPAGE="https://github.com/DamirPorobic/kImageAnnotator"
SRC_URI=""

EGIT_REPO_URI="https://github.com/DamirPorobic/kImageAnnotator"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="ce56f7b63580140ae77db534c9e3c52d3a0d8485"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	x11-libs/kcolorpicker"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	# Fix: https://github.com/DamirPorobic/kImageAnnotator/issues/43
	eapply "${FILESDIR}"/${P}_set_blurRadiusWidget_to_nullptr_in_constructor.patch
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)

	cmake-utils_src_configure
}
