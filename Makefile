# $Ragnarok: Makefile,v 1.3 2025/06/13 16:28:54 lecorbeau Exp $
# Makefile for pkgscripts.

SCRIPTS		= pkg_delete pkg_install sysclean
MANPAGES	= pkg_install.1

# For the tarball
VERSION		= 0.1
PKGNAME		= ragnarok-pkgscripts-${VERSION}

all:
	@echo "Nothing to do for all. Skipping..."

install:
	install -d ${DESTDIR}/usr/bin
	install -d ${DESTDIR}/usr/share/man/man1
	install ${SCRIPTS} ${DESTDIR}/usr/bin
	install ${MANPAGES} ${DESTDIR}/usr/share/man/man1

# Create a tarball for the ebuild.
pkg:
	tar czvf ${PKGNAME}.tgz Makefile ${SCRIPTS} ${MANPAGES}
