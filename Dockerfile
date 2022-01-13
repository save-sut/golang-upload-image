##
## Build
##

FROM golang:1.17.0-alpine3.13 AS build

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY *.go ./

RUN go build -o /dgolang-upload-image

##
## Deploy
##

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /dgolang-upload-image /dgolang-upload-image

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/dgolang-upload-image"]
