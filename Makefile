# Makefile for building on different platforms and architectures

.PHONY: all linux arm macos windows clean image

# Docker image tag
IMAGE_TAG=myapp:latest

all: linux arm macos windows

linux:
	GOOS=linux GOARCH=amd64 go build -o build/linux/myapp main.go

arm:
	GOOS=linux GOARCH=arm64 go build -o build/arm/myapp main.go

macos:
	GOOS=darwin GOARCH=amd64 go build -o build/macos/myapp main.go

windows:
	GOOS=windows GOARCH=amd64 go build -o build/windows/myapp.exe main.go

image:
	docker build --build-arg TARGETOS=linux --build-arg TARGETARCH=amd64 -t $(IMAGE_TAG) .

clean:
	rm -rf build
	-@docker rmi $(IMAGE_TAG) || true
