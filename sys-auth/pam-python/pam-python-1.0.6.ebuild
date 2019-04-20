# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python{2_6,2_7})
inherit python-single-r1

DESCRIPTION="PAM module that runs the Python interpreter and so allows PAM modules to be written in Python" 
HOMEPAGE="https://sourceforge.net/projects/pam-python/"
SRC_URI="https://sourceforge.net/p/pam-python/tickets/_discuss/thread/5dc8cfd5/5839/attachment/pam-python-1.0.6-fedora.patch
	https://sourceforge.net/p/pam-python/tickets/_discuss/thread/5dc8cfd5/5839/attachment/pam-python-1.0.6-gcc8.patch
	mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples"

RDEPEND="${PYTHON_DEPS} >=sys-libs/pam-0.76 sys-libs/glibc"
DEPEND="${DEPEND}"
BDEPEND="sys-devel/gcc
		doc? ( dev-python/sphinx )"

src_prepare() {
	eapply "${DISTDIR}/${P}-gcc8.patch"

	eapply_user

	python_fix_shebang src/
	sed --in-place 's|LIBDIR ?= /lib/security|LIBDIR ?= /usr/lib/security|g' src/Makefile || die "sed failed"
#	sed --in-place 's|sphinx-build|sphinx-build2|g' doc/Makefile || die "sed failed"
}

src_compile() {
	emake lib
	if use doc ; then
		emake doc
	fi
}

src_install() {
	dodir /lib64/security/
	cp ${WORKDIR}/${P}/src/build/lib.linux-x86_64-2.7/pam_python.so ${D}/lib64/security/ || die
	dodoc ${WORKDIR}/${P}/README.txt ${WORKDIR}/${P}/pam-python.html ${WORKDIR}/${P}/ChangeLog.txt
	if use doc ; then
		dodoc -r ${WORKDIR}/${P}/doc/html
	fi
	if use examples ; then
		dodoc -r ${WORKDIR}/${P}/examples
	fi

}
