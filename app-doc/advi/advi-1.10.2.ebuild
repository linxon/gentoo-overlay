# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Unix-platform DVI previewer and a programmable presenter for slides written in LaTeX"
HOMEPAGE="http://gallium.inria.fr/advi/"
SRC_URI="http://gallium.inria.fr/advi/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2"
SLOT="0"
DEPEND=">=dev-lang/ocaml-4.04.0"
RDEPEND="${DEPEND}
	media-libs/freetype
	media-libs/tiff
	>=x11-libs/libXpm-3.5.12
	>=x11-libs/libXinerama-1.1.3
	media-libs/libpng
	media-libs/giflib
	app-text/texlive
	sys-libs/zlib
"
