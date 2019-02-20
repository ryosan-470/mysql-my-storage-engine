FROM mysql:8.0.14

ENV CMAKE_VERSION 3.13.3

RUN apt update && \
  apt install -y \
  curl \
  git \
  g++ \
  make \
  bison \
  ccache \
  libssl-dev \
  libncurses5-dev \
  procps \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /tmp/cmake && \
  cd /tmp/cmake && \
  curl -L https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz | tar zxf - && \
  cd cmake-${CMAKE_VERSION} && \
  ./configure && \
  make -j4 && \
  make install && \
  rm -rf /tmp/cmake

WORKDIR /opt
RUN git clone --single-branch --branch mysql-8.0.14 --depth 1 https://github.com/mysql/mysql-server.git
WORKDIR /opt/mysql-server
# build mysql-server
RUN cmake . -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/tmp/boost -DFORCE_INSOURCE_BUILD=1
# Install Dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN curl -L https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar -C /usr/local/bin -xzvf -
ADD *.sh ./
