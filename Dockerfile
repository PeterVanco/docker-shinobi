FROM arm32v7/node:8-slim

LABEL Author="MiGoller, PeterVanco"

# Set environment variables to default values
ENV ADMIN_USER=admin@shinobi.video \
    ADMIN_PASSWORD=administrator \
    CRON_KEY=fd6c7849-904d-47ea-922b-5143358ba0de \
    PLUGINKEY_MOTION=b7502fd9-506c-4dda-9b56-8e699a6bc41c \
    PLUGINKEY_OPENCV=f078bcfe-c39a-4eb5-bd52-9382ca828e8a \
    PLUGINKEY_OPENALPR=dbff574e-9d4a-44c1-b578-3dc0f1944a3c \
    MOTION_HOST=localhost \ 
    MOTION_PORT=8080 

# Create custom and work dir
RUN mkdir -p /config /opt/shinobi

WORKDIR /opt/shinobi

# Raspberry Pi specific ffmpeg static build
# from https://github.com/idlerun/ffmpeg-raspi

# ADD ffmpeg.rpi /usr/bin/ffmpeg

# # Install package dependencies
# RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list \
#     && apt-get update \
#     && apt-get install -y python pkg-config libcairo-dev make g++ libjpeg-dev git mysql-client \
#     && apt-get clean

# Install package dependencies
RUN apt-get update \
    && apt-get install -y python pkg-config libcairo-dev make g++ libjpeg-dev git mysql-client ffmpeg \
    && apt-get clean

# merge RUNs after things start working
RUN git clone https://gitlab.com/Shinobi-Systems/Shinobi . \
    npm install pm2 -g \
    npm install

# Copy code
COPY docker-entrypoint.sh pm2Shinobi.yml ./

# this should happen in the repository, not docker image :/
RUN chmod -f +x ./*.sh

# Copy default configuration files
COPY config ./
COPY plugins ./plugins/

VOLUME ["/opt/shinobi/videos"]
VOLUME ["/config"]

EXPOSE 8080

ENTRYPOINT ["/opt/shinobi/docker-entrypoint.sh"]

CMD ["pm2-docker", "pm2Shinobi.yml"]
