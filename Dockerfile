# builder
FROM golang:1.11.4-alpine3.8 AS builder
RUN apk --update add git && \
  go get github.com/revel/revel && \
  go get github.com/revel/cmd/revel
COPY . /go/src/build
RUN revel build /go/src/build /tmp/app

# deploy container
FROM alpine:3.8
WORKDIR /app
COPY --from=builder /tmp/app /app/
EXPOSE 9000
ENTRYPOINT ["./run.sh"]
