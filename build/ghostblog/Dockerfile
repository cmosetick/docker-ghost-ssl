# Pull base image.
FROM ubuntu:14.04

# Install basics
RUN \
  #Use preferred Ubuntu mirror or comment out for default
  sed -i 's@http://archive.ubuntu.com/ubuntu/@http://ubuntu.osuosl.org/ubuntu@g' /etc/apt/sources.list && \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl wget git htop unzip man

# Install Python
RUN apt-get install -y python python-dev python-pip python-virtualenv

# Install Node.js stable from Ubuntu PPA
# more info: https://launchpad.net/~chris-lea/+archive/ubuntu/node.js
RUN \
# Install Node.js from Ubuntu PPA
  add-apt-repository --yes ppa:chris-lea/node.js && \
  apt-get update && \
  apt-get install -y nodejs && \
  echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bash_profile

# OR Install Node.js from latest tarball if you want absolute bleeding edge
#RUN \
#  apt-get install -y build-essential && \
#  cd /tmp && \
#  wget http://nodejs.org/dist/node-latest.tar.gz && \
#  tar xvzf node-latest.tar.gz && \
#  rm -f node-latest.tar.gz && \
#  cd node-v* && \
#  ./configure && \
#  CXX="g++ -Wno-unused-local-typedefs" make && \
#  CXX="g++ -Wno-unused-local-typedefs" make install && \
#  cd /tmp && \
#  rm -rf /tmp/node-v* && \

# Install Ghost
RUN \
  cd /tmp && \
  wget https://ghost.org/zip/ghost-latest.zip && \
  unzip ghost-latest.zip -d /ghost && \
  rm -f ghost-latest.zip && \
  cd /ghost && \
  npm install --production

# Add files.
ADD files/start.bash /ghost-start

# Set environment variables.
ENV NODE_ENV production

# Define mountable directories.
VOLUME ["/data", "/ghost-override"]

# Define working directory.
WORKDIR /ghost

# Define default command.
CMD ["bash", "/ghost-start"]

# Expose ports.
EXPOSE 2368
