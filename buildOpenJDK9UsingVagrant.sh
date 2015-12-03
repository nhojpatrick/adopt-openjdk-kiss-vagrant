#!/bin/bash

export VAGRANT_BOX_CPUS=2 ;
export VAGRANT_BOX_MEMORY=4096 ;

USAGE="usage: ${EXEC_NAME} [jdk9 | jigsaw | vahalla]" ;

if [ "$#" -lt 1  ]; then
	echo "Missing build name parameter" ;
	echo "${USAGE}" ;
	exit ;
fi

export BUILD_NAME="${1}" ;

if [ ! -f ./scripts/env/${BUILD_NAME}/setenv.sh ] ; then
	echo "Invalid build name parameter [./scripts/env/${BUILD_NAME}/setenv.sh]" ;
	echo "${USAGE}" ;
	exit ;
fi

echo "***************************************************************************************"
echo "*                                                                                     *"
echo "* Vagrant start the VM (if not active)                                                *"
echo "*                                                                                     *"
echo "***************************************************************************************"
vagrant up ;

EXIT_CODE=${?} ;
if [ ${EXIT_CODE} -ne 0 ]
then
  echo "ERROR exiting due to non zero exit code, vagrant up returned ${EXIT_CODE}" >&2
  exit 1
fi

echo "***************************************************************************************"
echo "*                                                                                     *"
echo "* Vagrant ssh-ing into the box, to execute OpenJDK commands...                        *"
echo "*                                                                                     *"
echo "***************************************************************************************"
vagrant ssh -c "sh /vagrant/scripts/buildOpenJDK.sh ${BUILD_NAME}" ;

EXIT_CODE=${?} ;
if [ ${EXIT_CODE} -ne 0 ]
then
  echo "ERROR exiting due to non zero exit code, vagrant ssh -c \"sh /vagrant/scripts/buildOpenJDK.sh ${BUILD_NAME}\" returned ${EXIT_CODE}" >&2
  exit 1
fi

echo "***************************************************************************************"
echo "*                                                                                     *"
echo "* Vagrant ssh into the box, into command prompt                                       *"
echo "*                                                                                     *"
echo "***************************************************************************************"
vagrant ssh ;

EXIT_CODE=${?} ;
if [ ${EXIT_CODE} -ne 0 ]
then
  echo "ERROR exiting due to non zero exit code, vagrant ssh returned ${EXIT_CODE}" >&2
  exit 1
fi
