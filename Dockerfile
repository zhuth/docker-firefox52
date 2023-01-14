FROM debian:stretch-slim
LABEL maintainer "Daniele Tricoli <eriol@mornie.org>"

ENV LAST_UPDATE 2022-01-14

RUN mkdir -p /usr/share/man/man1 \
    && sed -i 's@deb.debian.org@mirror.sjtu.edu.cn@' /etc/apt/sources.list \
    && sed -i 's@security.debian.org@mirror.sjtu.edu.cn@' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y \
	fcitx wget vnc4server tigervnc-common \
        ca-certificates \
        icedtea-netx-common \
        --no-install-recommends \
    && wget http://mirror.sjtu.edu.cn/debian/pool/main/f/firefox-esr/firefox-esr_52.8.1esr-1~deb8u1_amd64.deb -O /tmp/ff.deb
RUN dpkg -i /tmp/ff.deb; apt-get -f install -yq \
    && rm -rf /var/lib/apt/lists/* /tmp/ff.deb \
    && apt -qqy clean

ENV LANG en-US
ENV DISPLAY :1

COPY startup.sh / 

ENTRYPOINT ["bash", "/startup.sh"]
