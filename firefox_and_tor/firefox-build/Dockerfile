FROM debian:latest
ENV DEBIAN_FRONTEND noninteractive
RUN apt clean && apt update
RUN apt install -y firefox-esr --no-install-recommends
RUN apt install -y xauth --no-install-recommends
RUN apt clean
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
