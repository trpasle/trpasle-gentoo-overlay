# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit rpm

SRC_URI="https://www.rememberthemilk.com/download/linux/fedora/21/x86_64/rememberthemilk-1.2.2-1.x86_64.rpm"
SLOT="0"

KEYWORDS="~amd64"

src_unpack() {
    rpm_src_unpack ${A}

	mkdir -p "$S"
	mv "$WORKDIR/etc/" "$WORKDIR/opt/" "$WORKDIR/usr/" "$S"
}

src_install() {
	insinto /
	doins -r opt
}
