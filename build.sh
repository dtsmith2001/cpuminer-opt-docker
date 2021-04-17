#!/usr/bin/env bash

#
# Build Docker image for cpuminer-opt and optionally push to DockerHub
# See 
#

set -e

usage_print() {
	echo "$0 [-n | --no-cache] [-u | --username <username>] [-v | --version <version>] [-p | --push]"
	echo "-n | --no-cache Optional. If present, pass --no-cache to docker build command."
	echo "-u | --username <username> Optional. Username to be created for the container. Defaults to admin."
	echo "-v | --version <version> Optional. cpuminer-opt version (see https://github.com/JayDDee/cpuminer-opt/releases). Omit the 'v'. Defaults to 3.16.2."
	echo "-p | --push Optional. Push to DockerHub. Used by the author; requires 'docker login' with proper credentials."
}

no_cache=""
version="3.16.2"
will_push=0
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
            shift
            will_push=1
            shift
            ;;
        -h | --help)
            usage_print
            exit 1
        *)
            echo "Unknown argument: $1"
            usage_print
            exit 1
            ;;
    esac
done

echo "Build Docker image dtsmith2001/cpuminer-opt:v${version} using version v${version}".

docker build ${no_cache} --build-arg username=${username} --build-arg cpuminer_opt_version=${version} --tag dtsmith2001/cpuminer-opt:v${version} -f cpuminer-opt.dockerfile .

echo "Build successful. Use 'docker run --rm -it dtsmith2001/cpuminer-opt:v${version}'"

if [ ${will_push} -eq 1 ]
then
	echo "Push to dtsmith2001/cpuminer-opt:v${version}"
    docker push dtsmith2001/cpuminer-opt:v${version}
    echo "Successfully pushed to DockerHub".
fi
