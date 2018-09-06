FROM fedora:28

ADD ./environment.yml .

RUN dnf update -y
RUN dnf install -y blas-devel boost-python3 # superlu5 ?
RUN dnf install -y gcc gcc-c++ kernel-devel gcc-gfortran libgfortran qt5-qttools-devel
RUN dnf install -y make automake cmake git curl bzip2 tar redis libpqxx-devel boost-devel
RUN dnf install -y yaml-cpp-devel lapack-devel
RUN dnf install -y java-1.8.0-openjdk
RUN dnf install -y socat # only for drone testing
RUN dnf install -y https://download.postgresql.org/pub/repos/yum/9.6/fedora/fedora-28-x86_64/pgdg-fedora96-9.6-4.noarch.rpm
RUN dnf install -y postgresql96
RUN git clone --recursive --branch 3.5.4 https://github.com/Cylix/cpp_redis.git && cd cpp_redis && git submodule init && git submodule update && mkdir build && cd build && cmake .. && make && make install && cd .. 
RUN curl --silent -o miniconda-installer.sh https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh && bash miniconda-installer.sh -b -p $HOME/anaconda3 
RUN $HOME/anaconda3/bin/conda env create -f environment.yml
