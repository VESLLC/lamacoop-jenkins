#!/bin/bash -ex

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


