#!/bin/bash -ex

GIT="${GIT:-/usr/bin/git}"
$GIT clone -b linux-6.1.y-cip --single-branch --depth 1 https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/


