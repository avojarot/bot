# Use the specified base image
FROM quay.io/projectquay/golang:1.20 AS builder

# Set build arguments for the target platform
ARG TARGETOS
ARG TARGETARCH

# Set the working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the application
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /app/main .

# Final stage - creating the output container
FROM busybox AS final
WORKDIR /app
COPY --from=builder /app/main .
ENTRYPOINT ["/app/main"]
