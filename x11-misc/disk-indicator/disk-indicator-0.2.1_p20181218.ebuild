# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="A program that will turn your Scroll/Caps/NumLock LED into hard disk indicator."
HOMEPAGE="https://github.com/MeanEYE/Disk-Indicator"
EGIT_REPO_URI="https://github.com/MeanEYE/Disk-Indicator"
EGIT_COMMIT="ec2d2f6833f038f07a72d15e2d52625c23e10b12"
KEYWORDS="amd64 ~x86"
RESTRICT="mirror"
LICENSE="GPL-3"
IUSE="debug thinkpad X"
SLOT="0"

RDEPEND="
	dev-libs/libbsd
	X? (
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
	)"

DEPEND="${RDEPEND}"

src_prepare() {
	local default_cflags="-Wall -Wextra -pedantic -Werror"

	sed -e "s/^PROJECT=[a-zA-Z_]*/PROJECT=${PN}/" \
		-e '/^COMPILE_FLAGS=*/d' \
		-e "s/^LINK_FLAGS=/LINK_FLAGS=${LDFLAGS} /" \
		-e "/^LINK_FLAGS=*/a COMPILE_FLAGS=${default_cflags} -D _DEFAULT_SOURCE ${CFLAGS}" \
		-i Makefile || die 'sed failed!'

	eapply_user
}

src_configure() {
	local econf=(
		"--console"
		$(use X && echo "--xorg")
		$(use thinkpad && echo "--thinkpad")
	)

	elog "Exec: ./configure.sh ${econf[@]}"
	./configure.sh ${econf[@]} || die
}

src_compile() {
	emake CC=$(tc-getCC) $(use debug && echo debug)
}

src_install() {
	dobin ${PN}

	dodoc \
		DEPENDS \
		AUTHORS \
		README.md \
		"${FILESDIR}"/config.sample
}

pkg_postinst() {
	elog
	elog "Usage:"
	elog "  ~$ cp /usr/share/doc/${P}/config.sample* ~/.disk_indicator"
	elog "  ~$ disk_indicator -c ~/.disk_indicator"
	elog
}
