# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3
DESCRIPTION="Algorithms Library Toolkit (ALT) is a tool from the area of stringology."
HOMEPAGE="https://alt.pecka.me/"
LICENSE="GPL-3"
# SRC_URI="alt-9999.tar.xz"
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
	|| ( sys-devel/gcc sys-devel/clang )"

src_prepare() {
	mkdir --verbose build && cd build/
	S="${WORKDIR}/${P}/build"
	../CMake/generate.py -wm || die
	default
}

src_configure() {
	cmake .. -DBUILD_TYPE=Release  || die
}

#src_compile() {
#	cd build/
#	bash build.sh -n -d release -m Release || die
#}
