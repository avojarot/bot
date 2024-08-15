APP := $(shell basename $(shell git remote get-url origin))
REGISTRY := avojarot
VERSION=$(shell git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")-$(shell git rev-parse --short HEAD)
TARGETOS=linux # linux darwin windows
TARGETARCH=amd64 # amd64 arm64

format:
	@gofmt -s -w ./

lint:
	@golint

test:
	@go test -v

build: format
	@CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o kbot -ldflags "-X=github.com/den-vasyilev/kbot/cmd.appVersion=${VERSION}"

image:
	@docker build -t $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH) .

clean:
	@rm -rf kbot
	@docker rmi $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH)
