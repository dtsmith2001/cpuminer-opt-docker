FROM ubuntu:20.04

# docker push dtsmith2001/cpuminer-opt:tagname

ARG DEBIAN_FRONTEND=noninteractive

ARG username
ARG cpuminer_opt_version=3.16.2

RUN apt update && apt upgrade -y && \
	apt -y install \
	curl \
	build-essential \
	automake \
	libssl-dev \
	libcurl4-openssl-dev \
	libjansson-dev \
	libgmp-dev \
	zlib1g-dev \
	git

RUN useradd -ms /bin/bash ${username}

RUN mkdir -p /home/${username}

WORKDIR /home/${username}

RUN curl -sS -L https://github.com/JayDDee/cpuminer-opt/archive/refs/tags/v${cpuminer_opt_version}.tar.gz -o - | tar xz

RUN cd cpuminer-opt-${cpuminer_opt_version} && \
	./autogen.sh && \
	CFLAGS="-O3 -march=native -Wall" ./configure --with-curl && \
	make && make install
RUN chown -R ${username}.${username} cpuminer-opt-${cpuminer_opt_version}

USER ${username}
