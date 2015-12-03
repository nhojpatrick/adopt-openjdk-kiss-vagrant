#!/bin/bash

BUILD_NAME=${1} ;

echo "***************************************************************************************"
echo "*                                                                                     *"
echo "* Creating folder sources if it does not exists                                       *"
echo "*                                                                                     *"
echo "***************************************************************************************"
mkdir -p /vagrant/sources

echo "***************************************************************************************"
echo "*                                                                                     *"
echo "* Changing into folder '/vagrant/sources' inside the VM                               *"
echo "*                                                                                     *"
echo "***************************************************************************************"
cd /vagrant/sources

SCRIPT_FILE=../scripts/env/${BUILD_NAME}/setenv.sh ;
. ${SCRIPT_FILE} ;
echo "***************************************************************************************"
echo "*                                                                                     *"
echo "* Setting up environment variables for ${BUILD_NAME} using ${SCRIPT_FILE}             *"
echo "*                                                                                     *"
echo "***************************************************************************************"

echo "***************************************************************************************"
echo "*                                                                                     *"
echo "* Run script to update sources and share with host                                    *"
echo "*                                                                                     *"
echo "***************************************************************************************"
sh ../scripts/source-share-with-host.sh

echo "***************************************************************************************"
echo "*                                                                                     *"
echo "* Changing into folder $JDK_FOLDER                                                    *"
echo "*                                                                                     *"
echo "***************************************************************************************"
cd $JDK_FOLDER

echo "***********************************************************************************************"
echo "*                                                                                             *"
echo "* Start configure build system for ${BUILD_NAME} with 'bash configure $BASH_CONFIGURE_PARAMS' *"
echo "*                                                                                             *"
echo "***********************************************************************************************"
bash configure $BASH_CONFIGURE_PARAMS

echo "***************************************************************************************"
echo "*                                                                                     *"
echo "* Start building ${BUILD_NAME} with 'make $MAKE_PARAMS'                               *"
echo "*                                                                                     *"
echo "***************************************************************************************"
make $MAKE_PARAMS
