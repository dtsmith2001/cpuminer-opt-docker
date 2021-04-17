#!/usr/bin/env bash

#
# Build Docker image for cpuminer-opt and optionally push to DockerHub.
#
# The version of the Docker image corresponds to the release version.
# See https://github.com/JayDDee/cpuminer-opt/releases
#

set -e

usage_print() {
	echo "$0 [-n | --no-cache] [-u | --username <username>] [-v | --version <version>] [-p | --push]"
	echo "-n | --no-cache Optional. If present, pass --no-cache to docker build command."
	echo "-u | --username <username> Optional. Username to be created for the container. Defaults to admin."
	echo "-v | --version <version> Optional. cpuminer-opt version (see https://github.com/JayDDee/cpuminer-opt/releases). Omit the 'v'. Defaults to 3.16.2."
	echo "-p | --push Optional. Push to DockerHub. This will not work for everyone since it requires 'docker login'."
}

no_cache=""
version="3.16.2"
will_push=0
username="admin"
while [ $# -ge 1 ]
do
    case "$1" in
        -n | --no-cache)
            no_cache="--no-cache"
            shift
            ;;
        -u | --username)
			shift
			username=$1
			shift
			;;
        -v | --version)
            shift
            version=$1
            shift
            ;;
        -p | --push)
            will_push=1
            shift
            ;;
        -h | --help)
            usage_print
            exit 1
            ;;
        *)
            echo "Unknown argument: $1"
            usage_print
            exit 1
            ;;
    esac
done

echo "Build Docker image dtsmith2001/cpuminer-opt:v${version} using version v${version} with username ${username}."

docker build ${no_cache} --build-arg username=${username} --build-arg version=${version} --tag dtsmith2001/cpuminer-opt:v${version} -f cpuminer-opt.dockerfile .

echo "Build successful."
echo "Use 'docker run -rm -v $(pwd):/home/${username}/cpuminer dtsmith2001/cpuminer-opt:v${version}'"
echo "Use 'docker run -rm -d -v $(pwd):/home/${username}/cpuminer dtsmith2001/cpuminer-opt:v${version}' for a detached container."

if [ ${will_push} -eq 1 ]
then
	echo "Push to dtsmith2001/cpuminer-opt:v${version}"
	
    docker push dtsmith2001/cpuminer-opt:v${version}
    
    echo "Successfully pushed to DockerHub".
fi
