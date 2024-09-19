FROM golang:1.19.1 as builder

LABEL org.opencontainers.image.description="Dockerized Astrix Stratum Bridge"      
LABEL org.opencontainers.image.authors="theretromike"  
LABEL org.opencontainers.image.source="https://github.com/TheRetroMike/astrix-stratum-bridge"
              
WORKDIR /go/src/app
ADD go.mod .
ADD go.sum .
RUN go mod download

ADD . .
RUN go build -o /go/bin/app ./cmd/astrixbridge


FROM gcr.io/distroless/base:nonroot
COPY --from=builder /go/bin/app /
COPY cmd/astrixbridge/config.yaml /

WORKDIR /
ENTRYPOINT ["/app"]
