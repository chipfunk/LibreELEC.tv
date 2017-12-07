 
################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="brutefir"
PKG_VERSION="1.0o"
PKG_REV="114"
PKG_ARCH="any"
PKG_ADDON_PROJECTS="Generic RPi RPi2 imx6 WeTek_Hub WeTek_Play_2 Odroid_C2"
PKG_LICENSE="Proprietary"
PKG_SITE="https://www.ludd.ltu.se/~torger/brutefir.html"
PKG_URL="https://www.ludd.ltu.se/~torger/files/brutefir-1.0o.tar.gz"
PKG_SOURCE_DIR="$PKG_NAME-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain fftw"
PKG_SECTION="service/system"
PKG_SHORTDESC="BruteFIR software convolution engine"
PKG_LONGDESC="BruteFIR is a software convolution engine, a program for applying long FIR filters to multi-channel digital audio, either offline or in realtime."
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="BruteFIR"
PKG_ADDON_TYPE="xbmc.service"

make_target() {
  CC_FLAGS=`echo $CC_FLAGS | sed s/-msse//g` LIB_TARGETS="cli.bflogic eq.bflogic file.bfio alsa.bfio" make -e
}
