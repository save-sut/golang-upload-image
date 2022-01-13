##
## Build
##

FROM golang:1.16-buster AS build

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY *.go ./

RUN go build -o /golang-upload-image

##
## Deploy
##

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /golang-upload-image /golang-upload-image

EXPOSE 8000

USER nonroot:nonroot

ENTRYPOINT ["/golang-upload-image"]
