# $Ragnarok: Makefile,v 1.10 2025/11/29 16:48:26 lecorbeau Exp $
# Makefile for pkgscripts.
# NOTE: At some point it would be smart to use a Makefile.pl instead.

SCRIPTS		= pkg_install sysclean sysupdate mksysupdate reposign
PERL_MODS	= PkgScripts/Config.pm PkgScripts/Emerge.pm
PERL_VERSION	= 5.40
PERL_MOD_DIR	= /usr/lib64/vendor_perl/${PERL_VERSION}/Ragnarok/PkgScripts
LIBS		= lib/download
LIB_DIR		= /usr/lib/ragnarok
MANPAGES	= pkg_install.1 reposign.1 sysupdate.1 pkgscripts.conf.5 \
		  mksysupdate.1 sysclean.1

# For the tarball
VERSION		= 0.1
PKGNAME		= ragnarok-pkgscripts-${VERSION}

all:
	@echo "Nothing to do for all. Skipping..."

dirs:
	install -d ${DESTDIR}/etc
	install -d ${DESTDIR}/usr/bin
	install -d ${DESTDIR}/usr/share/man/man1
	install -d ${DESTDIR}/${PERL_MOD_DIR}
	install -d ${DESTDIR}/${LIB_DIR}

install: dirs
	install -m 644 pkgscripts.conf ${DESTDIR}/etc
	install -m 755 ${SCRIPTS} ${DESTDIR}/usr/bin
	install -m 644 ${PERL_MODS} ${DESTDIR}/${PERL_MOD_DIR}
	install -m 755 ${LIBS} ${DESTDIR}/${LIB_DIR}
	install -m 644 ${MANPAGES} ${DESTDIR}/usr/share/man/man1

# Create a tarball for the ebuild.
# Instruction: create the pkg dir, then run
# 'make DESTDIR=/path/to/pkgdir pkg
pkg: install
	cp Makefile ${PKGNAME}/
	tar czvf ${PKGNAME}.tgz ${PKGNAME}
