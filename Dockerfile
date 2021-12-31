FROM golang:1.17.0-alpine3.13 AS build

WORKDIR /go/src

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o app .

FROM alpine:latest

WORKDIR /app

COPY --from=build /go/src/app .

EXPOSE 8000

CMD ["./app"]