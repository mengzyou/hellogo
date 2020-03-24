FROM golang:1.14-alpine AS builder
ADD . /go/src/hellogo
RUN go install hellogo

FROM alpine:3.8
ENV GOSU_VERSION=1.11
COPY --from=builder /go/bin/hellogo .
RUN adduser --disabled-password --no-create-home runner root \
  && wget -q https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64 -O /usr/local/bin/gosu \
  && chmod +x /usr/local/bin/gosu
ENV PORT 8080
CMD ["gosu runner ./hellogo"]
