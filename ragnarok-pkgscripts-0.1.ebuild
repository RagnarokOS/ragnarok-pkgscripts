# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Package handling scripts for Ragnarok"
HOMEPAGE="https://github.com/RagnarokOS/ragnarok-pkgscripts"
SRC_URI="https://github.com/RagnarokOS/ragnarok-pkgscripts/releases/downloads/${PVR}/ragnarok-pkgscripts-${PVR}.tgz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	app-shells/oksh
	dev-perl/List-Compare
	dev-perl/ConfigGeneral
	acct-group/sysupdate
	acct-user/sysupdate"
RDEPEND="${DEPEND}"
