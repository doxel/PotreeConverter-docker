FROM debian:stretch-slim

ARG user=doxel
ARG debian_mirror=deb.debian.org

# setup system and get build dependencies
RUN useradd --create-home --shell /bin/bash $user \
 && mkdir /home/$user/src \
 && chown $user:$user /home/$user/src \
 && sed -r -i -e s/deb.debian.org/$debian_mirror/ /etc/apt/sources.list
# && apt-get update && apt-get install -y \
#      build-essential \
#      cmake \
#      git

USER $user

# copy our working build
COPY PotreeConverter /home/$user/src/PotreeConverter/build/PotreeConverter

# copy our page template
COPY resources /home/$user/src/PotreeConverter/build/PotreeConverter/resources

WORKDIR /home/$user
ENV PATH ${PATH}:/home/$user/src/PotreeConverter/build/PotreeConverter/

# dont use login shell to preserve PATH
CMD ["/bin/bash"]
