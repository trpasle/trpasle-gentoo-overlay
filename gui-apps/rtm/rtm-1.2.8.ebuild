# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit desktop rpm

SRC_URI="https://www.rememberthemilk.com/download/linux/fedora/21/x86_64/rememberthemilk-1.2.8-1.x86_64.rpm"
DESCRIPTION="Client for the Remember the Milk TODO list service"
HOMEPAGE="https://www.rememberthemilk.com/"
SLOT="0"
# RESTRICT="strip"

KEYWORDS="~amd64"
DEPEND="
		app-accessibility/at-spi2-atk
		app-accessibility/at-spi2-core
		app-arch/bzip2
		dev-libs/atk
		dev-libs/expat
		dev-libs/fribidi
		dev-libs/glib
		dev-libs/gmp
		dev-libs/libbsd
		dev-libs/libffi
		dev-libs/libpcre
		dev-libs/libtasn1
		dev-libs/libunistring
		dev-libs/nettle
		>=dev-libs/nss-3
		>=dev-libs/nspr-4
		dev-libs/wayland
		media-gfx/graphite2
		media-libs/alsa-lib
		media-libs/fontconfig
		media-libs/freetype
		media-libs/harfbuzz
		>=media-libs/libpng-1.6
		media-libs/libepoxy
		media-libs/libglvnd
		media-libs/mesa
		net-dns/libidn2
		net-libs/gnutls
		net-print/cups
		sys-apps/dbus
		sys-apps/util-linux
		sys-devel/gcc
		sys-libs/glibc
		sys-libs/zlib
		x11-libs/gdk-pixbuf
		>=x11-libs/gtk+-3
		x11-libs/libdrm
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libxcb
		x11-libs/libXcomposite
		x11-libs/libXcursor
		x11-libs/libXdamage
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXi
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXScrnSaver
		x11-libs/libXtst
		x11-libs/pango
		x11-libs/cairo
		x11-libs/pixman
		"

src_unpack() {
	rpm_src_unpack ${A}

	mkdir -p "$S"
	mv "$WORKDIR/etc/" "$WORKDIR/opt/" "$WORKDIR/usr/" "$S"
}

src_install() {
	into /
	insinto /
	exeinto /opt/RememberTheMilk-${PV}/
	doins -r opt
	doexe opt/RememberTheMilk-${PV}/rememberthemilk
	newicon opt/RememberTheMilk-${PV}/resources/app.asar.unpacked/resources/app-icon-win10.ico RememberTheMilk.ico
	make_desktop_entry /opt/RememberTheMilk-${PV}/rememberthemilk "Remember The Milk" /usr/share/pixmaps/RememberTheMilk.ico
}
