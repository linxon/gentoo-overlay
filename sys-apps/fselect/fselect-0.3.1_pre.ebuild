# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
CRATES="
	chrono-0.4.0
	csv-1.0.0-beta.5
	csv-core-0.1.4
	memchr-1.0.0
	memchr-2.0.0
	libc-0.2.18
	serde-1.0.7
	humansize-1.1.0
	imagesize-0.5.0
	regex-0.2.6
	regex-syntax-0.4.1
	thread_local-0.3.2
	utf8-ranges-1.0.0
	aho-corasick-0.6.0
	serde_json-1.0.10
	dtoa-0.4.0
	itoa-0.3.0
	term-0.5.0
	byteorder-1.2.1
	zip-0.3.1
	bzip2-0.3.0
	bzip2-sys-0.1.0
	flate2-1.0.0
	msdos_time-0.1.0
	podio-0.1.0
	users-0.6.0
	num-0.1.42
	num-iter-0.1.35
	num-integer-0.1.36
	num-traits-0.2.0
	time-0.1.39
	winapi-0.3.0
	winapi-i686-pc-windows-gnu-0.3.0
	winapi-x86_64-pc-windows-gnu-0.3.0
	redox_syscall-0.1.37"

inherit cargo

DESCRIPTION="Find files with SQL-like queries"
HOMEPAGE="https://github.com/jhspetersson/fselect"

SRC_URI="
	https://github.com/jhspetersson/fselect/archive/${PV%%_pre}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})"

RESTRICT="mirror"
KEYWORDS="~amd64"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/cargo"

S="${WORKDIR}"/${PN}-${PV%%_pre}
