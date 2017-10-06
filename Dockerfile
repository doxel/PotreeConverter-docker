FROM debian:jessie-slim

ARG user=doxel
ARG debian_mirror=deb.debian.org

# setup system and get build dependencies
RUN useradd --create-home --shell /bin/bash $user \
 && mkdir /home/$user/src \
 && chown $user:$user /home/$user/src \
 && sed -r -i -e s/deb.debian.org/$debian_mirror/ /etc/apt/sources.list \
 && apt-get update && apt-get install -y \
      build-essential \
      cmake \
      git

RUN apt-get install libboost-all-dev -y
USER $user
# clone build and install
WORKDIR /home/$user/src
RUN git clone \
   --single-branch \
   -b master \
   https://github.com/m-schuetz/LAStools.git \
 && cd LAStools \
 && git checkout 8065ce39d50d09907691b5feda0267279428e586 \
 && cd LASzip \
 && mkdir build \
 && cd build \
 && cmake -DCMAKE_BUILD_TYPE=Release .. \
 && make -j $(nproc) \
 && cd /home/$user/src \
 && git clone \
   --single-branch \
   -b develop \
   --recursive \
   https://github.com/potree/PotreeConverter.git \
 && cd PotreeConverter \
 && git checkout b8c8df7914aa082ebd399798b8171ba96014bd17 \
 && mkdir build \
 && cd build \
 && cmake \
   -DCMAKE_BUILD_TYPE=Release \
   -DLASZIP_INCLUDE_DIRS=/home/$user/src/LAStools/LASzip/dll \
   -DLASZIP_LIBRARY=/home/$user/src/LAStools/LASzip/build/src/liblaszip.so \
   .. \
 && make -j $(nproc)

# copy our page template
COPY resources /home/$user/src/PotreeConverter/build/PotreeConverter/resources

WORKDIR /home/$user
ENV PATH ${PATH}:/home/$user/src/PotreeConverter/build/PotreeConverter/

# dont use login shell to preserve PATH
CMD ["/bin/bash"]
