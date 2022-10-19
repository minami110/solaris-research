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
HIPNAME="motion-blur-aov"
HIPFILE="$(realpath ${BASEDIR})/${HIPNAME}.hip"
NUMPROC=32
DRIVER="/stage/usdrender_rop1"
START=1
END=24
INTERVAL=1

# Render
hbatch -i -j ${NUMPROC}\
    -c "render -f ${START} ${END} -i ${INTERVAL} ${DRIVER}"\
    -c "quit -f 0"\
    ${HIPFILE}