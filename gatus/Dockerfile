# ---------- Stage 1: Build ----------
FROM golang:alpine AS builder

# Install TLS/SSL-certificates (--no-cache minimizes the image)
RUN apk add --no-cache ca-certificates

# Create non-root user for security
RUN adduser -u 1001 -D nonroot

# Set the working directory
WORKDIR /app

# Cache dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build the Go app
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o gatus .

# ---------- Stage 2: Final ----------
# Use a minimal scratch image as the base image for the final image
FROM scratch

# Copy the /etc/passwd file from the build stage to provide non-root user information
COPY --from=builder /etc/passwd /etc/passwd

# Copy the binary, the config file and the certificates
COPY --from=builder /app/gatus .
COPY --from=builder /app/config.yaml ./config/config.yaml
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# Run as non-root user
USER nonroot

# Expose the port the application will run on
EXPOSE 8080

# Define the command to run the application when the container starts
ENTRYPOINT ["/gatus"]
