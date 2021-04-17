FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

ARG username=admin
ARG version=3.16.2

ENV user_name=${username}
ENV cpuminer_opt_version=${version}

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
	git \
	nano

RUN useradd -m -s /bin/bash ${user_name} && \
	usermod -aG sudo ${user_name} && \
	echo "${user_name} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /home/${user_name}

RUN curl -sS -L https://github.com/JayDDee/cpuminer-opt/archive/refs/tags/v${cpuminer_opt_version}.tar.gz -o - | tar xz

RUN cd cpuminer-opt-${cpuminer_opt_version} && \
	./autogen.sh && \
	CFLAGS="-O3 -march=native -Wall" ./configure --with-curl && \
	make && make install
RUN chown -R ${user_name}.${user_name} /home/${user_name}

USER ${user_name}
