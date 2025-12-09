#!/bin/bash -ex

# lamacoop-jenkins - Jenkins pipeline scripts for assisting docgen automation
# Copyright (C) 2025 VES LLC
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# For inquiries, please contact by email:
#   info@ves.solutions
#
# Or if you prefer, by paper mail:
#   VES LLC
#   6180 Guardian Gtwy, Ste 102
#   Aberdeen Proving Ground, MD 21005

cd linux-cip 
YES="${YES:-/usr/bin/yes}"
yes "" | make -j8
 


