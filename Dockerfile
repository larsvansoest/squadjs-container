FROM node:14-slim

LABEL maintainer="dev@larsvansoest.nl"
LABEL version="1.1"
LABEL description="Docker container containing a basic installation of the SquadJS scripting framework."

ARG DIR="/home/squadjs"
ARG GIT="https://github.com/Thomas-Smyth/SquadJS.git --single-branch"

WORKDIR ${DIR}/SquadJS

# Install required source.
RUN cd .. \
 && apt-get update \ 
 && apt-get install -y git \
 && rm -rf /var/lib/apt/lists/* \
 && git clone ${GIT} \
 && cd SquadJS \
 && yarn install

CMD [ "node", "index.js" ]
VOLUME ${DIR}