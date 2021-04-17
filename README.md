# cpuminer-opt-docker

Docker image for [cpuminer-opt](https://github.com/JayDDee/cpuminer-opt). Based on Ubuntu 20.04 LTS

# Obtaining the image

The version tag follows the cpuminer-opt [release tags](https://github.com/JayDDee/cpuminer-opt/releases).

```bash
docker pull dtsmith2001/cpuminer-opt:<version>
```

# Building the image locally

Use [`build.sh`](https://github.com/dtsmith2001/cpuminer-opt-docker/blob/main/build.sh).

```bash
./build.sh [-n | --no-cache] [-u | --username <username>] [-v | --version <version>] [-p | --push]
-n | --no-cache Optional. If present, pass --no-cache to docker build command.
-u | --username <username> Optional. Username to be created for the container. Defaults to admin.
-v | --version <version> Optional. cpuminer-opt version (see https://github.com/JayDDee/cpuminer-opt/releases). Omit the 'v'. Defaults to 3.16.2.
-p | --push Optional. Push to DockerHub. This will not work for everyone since it requires 'docker login'.
```
