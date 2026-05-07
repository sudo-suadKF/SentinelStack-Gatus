FROM golang:alpine AS builder

RUN apk add --no-cache ca-certificates

RUN adduser -u 1001 -D nonroot

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o gatus .

FROM scratch

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /app/gatus .
COPY --from=builder /app/config.yaml ./config/config.yaml
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

USER nonroot

EXPOSE 8080

ENTRYPOINT ["/gatus"]