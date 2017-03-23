FROM midvalestudent/jupyter-scipy:latest

USER root
ENV HOME=/root

# Download/build/install components for opencv
ARG OPENCV_VERSION
ENV OPENCV_VERSION ${OPENCV_VERSION:-"3.2.0"}
RUN DEBIAN_FRONTEND=noninteractive \
    && REPO=http://cdn-fastly.deb.debian.org \
    && echo "deb $REPO/debian jessie main\ndeb $REPO/debian-security jessie/updates main" > /etc/apt/sources.list \
    && apt-get update && apt-get -yq dist-upgrade \
    && apt-get install -yq --no-install-recommends \
        build-essential \
        cmake \
        git-core \
        pkg-config \
        libjpeg62-turbo-dev \
        libtiff5-dev \
        libjasper-dev \
        libpng12-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libv4l-dev \
        libatlas-base-dev \
        gfortran \
        tesseract-ocr \
        tesseract-ocr-eng \
        libtesseract-dev \
        libleptonica-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /usr/src/build && cd /usr/src/build \
    && git clone -b $OPENCV_VERSION --depth 1 --recursive https://github.com/opencv/opencv.git \
    && git clone -b $OPENCV_VERSION --depth 1 --recursive https://github.com/opencv/opencv_contrib.git \
    && cd opencv && mkdir build && cd build \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D OPENCV_EXTRA_MODULES_PATH=/usr/src/build/opencv_contrib/modules \
        -D BUILD_EXAMPLES=OFF .. \
    && make -j4 install && ldconfig \
    && cd /usr/src/build && rm -rf opencv && rm -rf opencv_contrib \
    && apt-get purge -y cmake && apt-get autoremove -y --purge

# back to unpriviliged user
ENV HOME=/home/$NB_USER
