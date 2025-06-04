# $Ragnarok: Makefile,v 1.2 2025/06/04 22:21:54 lecorbeau Exp $
# Makefile for pkgscripts.

SCRIPTS		= pkg_delete pkg_install sysclean
MANPAGES	= pkg_install.1

all:
	@echo "Nothing to do for all. Skipping..."

install:
	install -d ${DESTDIR}/usr/bin
	install -d ${DESTDIR}/usr/share/man/man1
	install ${SCRIPTS} ${DESTDIR}/usr/bin
	install ${MANPAGES} ${DESTDIR}/usr/share/man/man1
