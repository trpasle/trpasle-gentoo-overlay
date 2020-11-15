# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3
DESCRIPTION="Algorithms Library Toolkit (ALT) is a tool from the area of stringology."
HOMEPAGE="https://alt.pecka.me/"
LICENSE="GPL-3"
EGIT_REPO_URI="https://gitlab.fit.cvut.cz/algorithms-library-toolkit/automata-library.git"

KEYWORDS="~amd64"
SLOT="0"
DEPEND="media-gfx/graphviz[X]
	dev-cpp/tclap
	dev-libs/libxml2
	dev-libs/jsoncpp
	sys-libs/readline
	dev-util/cmake[qt5]
	dev-qt/qtxml
	>=sys-devel/gcc-10.0.0"

src_prepare() {
	mkdir --verbose build && cd build/
	GCCVERSION=""
	[ "$(gcc-config -c | grep -o  "\-[[:digit:]]*\." | grep -o "[[:digit:]]*")" -ge "10" ] ||
	GCCVERSION=$(gcc-config -l | grep "x86_64-pc-linux-gnu" | grep  -o  "\-[[:digit:]][[:digit:]].*[[:digit:]]")
	if [ "$GCCVERSION" != "" ]
	then
		CC=gcc"$GCCVERSION"
		CXX=g++"$GCCVERSION"
	fi
	S="${WORKDIR}/${P}/build"
	default
}

src_configure() {
	cmake .. -DBUILD_TYPE=Release  || die
}
