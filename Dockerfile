from golang:alpine as builder
RUN apk --no-cache add git
RUN go get -u github.com/improbable-eng/grpc-web/go/grpcwebproxy

ENV GOOS=linux
ENV GOARCH=arm
ENV GOARM=7
RUN go install github.com/improbable-eng/grpc-web/go/grpcwebproxy

from balenalib/raspberrypi3-alpine
RUN apk --no-cache add ca-certificates
WORKDIR /
COPY --from=builder /go/bin/grpcwebproxy .
ENTRYPOINT ["/grpcwebproxy"]
CMD []
