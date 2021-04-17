#!/usr/bin/env bash

#
# Build Docker image for cpuminer-opt and optionally push to DockerHub
#

set -e

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
        *)
            echo "Unknown argument: $1"
            usage_print
            exit 1
            ;;
    esac
done

docker build ${no_cache} --build-arg username=admin --build-arg cpuminer_opt_version=${version} --tag dtsmith2001/cpuminer-opt:v${version} -f cpuminer-opt.dockerfile .

if [ ${will_push} -eq 1 ]
then
    docker push dtsmith2001/cpuminer-opt:v${version}
fi
