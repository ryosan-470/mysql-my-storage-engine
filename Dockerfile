FROM mysql:8.0.15

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

WORKDIR /opt/mysql-server
ADD mysql-server /opt/mysql-server
# build mysql-server
RUN cmake /opt/mysql-server -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/tmp/boost -DFORCE_INSOURCE_BUILD=1
