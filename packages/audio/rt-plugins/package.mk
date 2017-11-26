################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="rt-plugins"
PKG_VERSION="0.0.6"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://faculty.tru.ca/rtaylor/rt-plugins/index.html"
PKG_URL="http://faculty.tru.ca/rtaylor/rt-plugins/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_SECTION="audio"
PKG_SHORTDESC="rt-plugins: LADSPA filters by Richard Taylor"
PKG_LONGDESC="This package includes the LADSPA-plugins by Richard Taylor."

PKG_AUTORECONF="no"

PKG_IS_ADDON="no"
PKG_ADDON_NAME="LADSPA RT-plugins"
PKG_ADDON_TYPE="xbmc.service.library"
PKG_ADDON_REQUIRES=""

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET=""

LADSPA_HEADER_DIR=$PWD/build.LibreELEC-$PROJECT.$ARCH-8.2.1/alsa-lib-1.1.4.1/src/pcm/

pre_configure_target() {
  export CFLAGS="$CFLAGS -I $LADSPA_HEADER_DIR"		# avoid installing ladspa-sdk
  export CFLAGS="$CFLAGS -w"				# avoid compiler-warning about inline
}

