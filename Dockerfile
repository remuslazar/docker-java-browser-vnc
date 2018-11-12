FROM alpine:3.7

MAINTAINER Remus Lazar <rl@cron.eu>

ARG S6_VERSION="1.21.2.2"

COPY root /

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-amd64.tar.gz /tmp/

RUN apk add --no-cache tar rsync curl sed bash git openssh pwgen sudo s6

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && rm /tmp/s6-overlay-amd64.tar.gz \
	&& chmod +x /github-keys.sh \
	&& sed -i -r 's/.?UseDNS\syes/UseDNS no/' /etc/ssh/sshd_config \
	&& sed -i -r 's/.?PasswordAuthentication.+/PasswordAuthentication no/' /etc/ssh/sshd_config \
	&& sed -i -r 's/.?ChallengeResponseAuthentication.+/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config \
	&& sed -i -r 's/.?PermitRootLogin.+/PermitRootLogin no/' /etc/ssh/sshd_config \
	&& sed -i '/secure_path/d' /etc/sudoers \
  && adduser -D alpine \
	&& echo 'alpine ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/alpine

# install jre, selenium, firefox and xvfb
RUN apk --no-cache add openjdk8 xorg-server xvfb ttf-opensans firefox-esr curl libvncserver openssl dbus

# we do compile x11vnc from sources (unfortunately there is no binary package available..)
RUN apk --no-cache add --virtual=.x11vncdeps gcc g++ automake autoconf make openssl-dev libx11-dev libvncserver-dev \
  && mkdir -p /src && cd /src \
  && git clone https://github.com/LibVNC/x11vnc \
  && cd x11vnc \
  && ./autogen.sh \
  && make \
  && make install \
  && apk del .x11vncdeps \
  && cd / && rm -rf /src

# Install Chromium
# RUN apk add --no-cache chromium

ENV \
  DISPLAY=:99 \
  SCREEN_DIMENSION=1280x1024x24 \
  VNC_PASSWORD=password

EXPOSE 4444 5900

# Define entrypoint and command
ENTRYPOINT ["/init"]
