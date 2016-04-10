#!/bin/bash

# Reference: https://github.com/janyou/ANTLR-Swift-Target/blob/master/ManuallyBuild.md

# Setup

pushd . > /dev/null
cd `dirname $0`
scriptRoot=`pwd`
popd > /dev/null

# Include

. "$scriptRoot/include/git"
. "$scriptRoot/include/integration"
. "$scriptRoot/include/sources"
. "$scriptRoot/include/dependencies"
. "$scriptRoot/include/build"
. "$scriptRoot/include/install"

# Options

gitFolder="/tmp/$(uuidgen)"
rebuild=false

# Functions

parseArguments() {
    while [ $# -gt 0 ]
    do
        case $1 in
            --rebuild) rebuild true; shift 1;;
            --gitFolder) [ $# -gt 1 ] && gitFolder=$2; shift 2;;
            --installFolder) [ $# -gt 1 ] && installFolder=$2; shift 2;;
            *) echo "Unexpected argument: $1"; exit 1; shift;;
        esac
    done
}

buildDependingOnOptions() {
    if $rebuild
    then
        build
    else
        buildIfNeeded
    fi
}

execute() {
    mkdir -p "$gitFolder"
    gitAntlrFolder="$gitFolder/antlr4"
    gitTargetFolder="$gitFolder/target"
    
    setupDependencies && getSources && integrateTargetInAntlr && buildDependingOnOptions && installIfNeeded
}

# Main

parseArguments $@
execute






