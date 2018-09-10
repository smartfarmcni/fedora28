FROM fedora:28

ADD ./environment.yml .

RUN dnf update -y && dnf install -y \
    blas-devel boost-python3 \
    gcc gcc-c++ kernel-devel gcc-gfortran libgfortran qt5-qttools-devel qt5-qtbase-devel \
    make automake cmake git curl bzip2 tar redis libpqxx-devel boost-devel \
    yaml-cpp-devel lapack-devel \
    java-1.8.0-openjdk \
    python3-psycopg2 python3-redis python3-ruamel-yaml python3-psutil \
    socat \
    && dnf install -y https://download.postgresql.org/pub/repos/yum/9.6/fedora/fedora-28-x86_64/pgdg-fedora96-9.6-4.noarch.rpm \
    && dnf install -y postgresql96 \
    && dnf clean all
RUN git clone --recursive --branch 3.5.4 https://github.com/Cylix/cpp_redis.git && \
    cd cpp_redis && git submodule init && git submodule update && mkdir build && cd build && \
    cmake .. && make && make install && cd ../.. && rm -rf cpp_redis
RUN curl --silent -o miniconda-installer.sh https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh && bash miniconda-installer.sh -b -p $HOME/anaconda3 && rm miniconda-installer.sh
RUN $HOME/anaconda3/bin/conda env create -f environment.yml
