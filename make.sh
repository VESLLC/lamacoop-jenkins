#!/bin/bash -ex

cd linux-cip 
YES="${YES:-/usr/bin/yes}"
yes "" | make -j8
 


