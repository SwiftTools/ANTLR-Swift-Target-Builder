#!/bin/bash

# Setup

pushd . > /dev/null
cd `dirname $0`
scriptRoot=`pwd`
popd > /dev/null

# Main

$scriptRoot/build.sh  --gitFolder ~/.antlrswift/src --installFolder ~/.antlrswift/bin
open ~/.antlrswift/bin