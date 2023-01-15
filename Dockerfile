FROM golang:1.19 as builder

WORKDIR /usr/src/app

COPY go.mod ./
RUN go mod download && go mod verify

COPY . /
RUN go build /hello.go
RUN pwd

FROM hello-world:latest
WORKDIR /
COPY --from=builder /usr/src/app/hello /hello

CMD ["/hello"]