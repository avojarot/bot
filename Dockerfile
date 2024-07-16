# Use an alternative container registry base image
FROM quay.io/projectquay/golang:1.20

# Set the working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the application for the target architecture
ARG TARGETOS
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o myapp ./cmd

# Use distroless image to reduce size and improve security
FROM gcr.io/distroless/base-debian10
COPY --from=0 /app/myapp /app/myapp
ENTRYPOINT ["/app/myapp"]
