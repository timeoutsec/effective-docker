FROM alpine:latest
RUN apk update && apk add tor
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
