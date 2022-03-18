# vim: ft=dockerfile

FROM debian:bullseye
RUN apt-get update -qq && \
  apt-get install -y \
    curl \
    gpg \
    iptables \
    procps \
    supervisor && \
  curl -fsSL "https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg" | gpg --dearmor -o /etc/apt/trusted.gpg.d/zerotier.gpg && \
  echo "deb https://download.zerotier.com/debian/bullseye/ bullseye main" > /etc/apt/sources.list.d/zerotier.list && \
  apt-get update -qq && \
  apt-get install -y \
    zerotier-one

COPY files/supervisor-zerotier.conf /etc/supervisor/supervisord.conf
COPY files/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
CMD []
ENTRYPOINT ["/entrypoint.sh"]