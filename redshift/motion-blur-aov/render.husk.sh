#!/bin/bash

# Feature flags
HOUDINI_VERSION="19.5.403"
REDSHIFT_VERSION="3.5.09"

# Redshift for Houdini
export "REDSHIFT_COREDATAPATH=${HOME}/.local/redshift/${REDSHIFT_VERSION}"
export "HOUDINI_PATH=${REDSHIFT_COREDATAPATH}/redshift4houdini/${HOUDINI_VERSION}:${HOUDINI_PATH}"

# Redshift for Solaris
export "PXR_PLUGINPATH_NAME=${REDSHIFT_COREDATAPATH}/redshift4solaris/${HOUDINI_VERSION}:${PXR_PLUGINPATH_NAME}"

# Add PATH to Houdini
export "HOUDINI_PATH=${HOUDINI_PATH}:&"
export "PATH=/opt/hfs${HOUDINI_VERSION}/bin:${PATH}"

# Render Settings 
BASEDIR=$(dirname $(realpath "$0"))
USDFILE="$(realpath ${BASEDIR})/stage.usd"
START=1
COUNT=24
INTERVAL=1

# Render
husk\
    --usd-input ${USDFILE}\
    --purpose "geometry,render"\
    --frame ${START}\
    --frame-count ${COUNT}\
    --frame-inc ${INTERVAL}\
    --renderer Redshift\
    --threads -1