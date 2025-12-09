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

MAKE="${MAKE:-/usr/bin/make}"
$MAKE defconfig

SED="${SED:-/usr/bin/sed}"
# NOTE Below is a fairly simple sed instruction which modifies the .config file, appending a line after line 153 with the text CONFIG_TASKS_RUDE_RCU=y
# NOTE each of the following lines unless stated operate the same
$SED -i '153a CONFIG_TASKS_RUDE_RCU=y' .config
$SED -i '643a CONFIG_KPROBES_ON_FTRACE=y' .config
$SED -i '4982a CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y' .config
$SED -i '4994a CONFIG_BUILDTIME_MCOUNT_SORT=y' .config

# NOTE Statement below finds, CONFIG_FUNCTION_TRACER is not set, and replaces it with CONFIG_FUNCTION_TRACER=y within the .config file
$SED -i 's\# CONFIG_FUNCTION_TRACER is not set\CONFIG_FUNCTION_TRACER=y\ ' .config

$SED -i '5006a CONFIG_FUNCTION_GRAPH_TRACER=y' .config
$SED -i '5008a CONFIG_DYNAMIC_FTRACE=y' .config
$SED -i '5010a CONFIG_DYNAMIC_FTRACE_WITH_REGS=y' .config
$SED -i '5011a CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y' .config
$SED -i '5012a CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y' .config
$SED -i '5029a CONFIG_FTRACE_MCOUNT_RECORD=y' .config
$SED -i '5031a CONFIG_FTRACE_MCOUNT_USE_CC=y' .config


