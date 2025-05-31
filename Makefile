# $Ragnarok: Makefile,v 1.1 2025/05/31 18:52:14 lecorbeau Exp $
# Makefile for pkgscripts.

SCRIPTS		= pkg_delete pkg_install sysclean
MANPAGES	= pkg_install.1

all: install

install:
	install -d ${DESTDIR}/usr/bin
	install -d ${DESTDIR}/usr/share/man/man1
	install ${SCRIPTS} ${DESTDIR}/usr/bin
	install ${MANPAGES} ${DESTDIR}/usr/share/man/man1
