# Build cpuminer-opt and Mine Cryptocurrency

Docker image for [cpuminer-opt](https://github.com/JayDDee/cpuminer-opt). Based on Ubuntu 20.04 LTS.

To use this image, please install Docker using

```bash
sudo apt install docker.io
```

Add yourself to the `docker` group

```bash
sudo usermod -aG docker $(whoami)
```

Log out and log back in.

# Obtaining the image

The version tag follows the cpuminer-opt [release tags](https://github.com/JayDDee/cpuminer-opt/releases).

```bash
docker pull dtsmith2001/cpuminer-opt:<version>
```

## Start a Container

```bash
docker run --rm -it dtsmith2001/cpuminer-opt:v3.16.2
```

At this point you are ready to use `cpuminer` to mine your favorite cryptocurrencies.

If you make a mistake, just `exit` the container. The container is removed since we have specified `--rm`. Then you can start a fresh container.

## Starting a Container for Mining in Detached Mode

I have a script called `mining.sh` which runs `cpuminer` when the container starts. I'm also mounting the current working directory inside the container at `/home/${username}/mining`. Then the container runs a particular script. I'm directing `cpuminer` to use `syslog` instead of printing messages to the screen.

```bash
docker run --volume $(pwd):/home/<username>/mining --rm --detach dtsmith2001/cpuminer-opt:v3.16.2 /home/<username>/mining/mining.sh
```

Use `docker ps` to find the container id and `docker stop` to stop it.

# Building the image locally

Use [`build.sh`](https://github.com/dtsmith2001/cpuminer-opt-docker/blob/main/build.sh).

```bash
./build.sh [-n | --no-cache] [-u | --username <username>] [-v | --version <version>] [-p | --push]
-n | --no-cache Optional. If present, pass --no-cache to docker build command.
-u | --username <username> Optional. Username to be created for the container. Defaults to admin.
-v | --version <version> Optional. cpuminer-opt version (see https://github.com/JayDDee/cpuminer-opt/releases). Omit the 'v'. Defaults to 3.16.2.
-p | --push Optional. Push to DockerHub. This will not work for everyone since it requires 'docker login'.
```
