# Use an official Ubuntu base image
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    binutils \
    vim \
    emacs \
    clang \
    gdb \
    libcjson1 \
    libxml2 \
    libssl-dev \
    curl \
    cmake \
    git \
    wget \
    python3 \
    python3-dev \
    python3-pip \
    sudo \
    libglib2.0-dev \
    libpixman-1-dev \
    ninja-build \
    psmisc \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m user -G sudo
# Enable passwordless sudo for the 'user'
RUN echo 'user ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/user

WORKDIR /usr/src/
RUN wget https://www.openssl.org/source/old/1.1.1/openssl-1.1.1f.tar.gz \
    && tar xf openssl-1.1.1f.tar.gz \
    && rm openssl-1.1.1f.tar.gz
WORKDIR /usr/src/openssl-1.1.1f/
RUN ./config && make && make install
# Configure library path for OpenSSL 1.1.1f
RUN echo '/usr/local/lib' > /etc/ld.so.conf.d/openssl.conf && ldconfig
RUN rm -rf /usr/src/openssl-1.1.1f

WORKDIR /usr/src/afl
# Download the AFLplusplus source from GitHub Releases
RUN wget https://github.com/AFLplusplus/AFLplusplus/archive/refs/tags/v4.20c.tar.gz \
    && tar -xzvf v4.20c.tar.gz \
    && rm v4.20c.tar.gz

# Move to the AFLplusplus directory
WORKDIR /usr/src/afl/AFLplusplus-4.20c

# Compile AFLplusplus
RUN make

# Install QEMU support for AFLplusplus
RUN cd qemu_mode && ./build_qemu_support.sh

WORKDIR /usr/src/afl/AFLplusplus-4.20c
RUN make install

RUN pip3 install --break-system-packages lief
RUN pip3 install frida-tools --break-system-packages

USER user
WORKDIR /home/user/USB

# Expose port 8080
EXPOSE 8080
CMD ["bash"]
