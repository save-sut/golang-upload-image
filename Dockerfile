# We need a golang build environment first
FROM golang:1.17.0-alpine3.13

WORKDIR /go/src/app
COPY . /go/src/app

RUN go build main.go

# We use a Docker multi-stage build here in order that we only take the compiled go executable
FROM alpine:3.14

LABEL org.opencontainers.image.source="https://github.com/save-sut/golang-upload-image"

COPY --from=0 "/go/src/app/" app

ENTRYPOINT ./app

EXPOSE 8000