FROM golang:1.23 as build

WORKDIR /go/src/app
COPY . /go/src/app

RUN CGO_ENABLED=0 go build -o /go/bin/app -buildvcs=false

FROM gcr.io/distroless/static-debian12

COPY --from=build /go/bin/app /
CMD ["/app", "--enable-health-check"]
