FROM golang:1.23-bullseye as dev

RUN go install github.com/air-verse/air@latest
WORKDIR /app
ADD . .
RUN go build -o /app/hello-world

FROM busybox
WORKDIR /app
COPY --from=dev /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=dev app/hello-world /app/hello-world 

EXPOSE 8080
CMD ["/app/hello-world"]