APP = $(shell basename $(shell git remote get-url origin))
REGISTRY := avojarot1
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

# Define target platforms
PLATFORMS = linux/amd64 linux/arm64 darwin/amd64 windows/amd64
BUILD_OUTPUT = output

.PHONY: all $(PLATFORMS)

# Default target to build all platforms
all: $(PLATFORMS)

$(PLATFORMS):
	$(eval TARGETOS=$(shell echo $@ | cut -d '/' -f 1))
	$(eval TARGETARCH=$(shell echo $@ | cut -d '/' -f 2))
	GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -o $(BUILD_OUTPUT)/$(TARGETOS)-$(TARGETARCH)/$(APP) .

docker: $(PLATFORMS)
	for platform in $(PLATFORMS); do \
		$(eval TARGETOS=$(shell echo $$platform | cut -d '/' -f 1)) \
		$(eval TARGETARCH=$(shell echo $$platform | cut -d '/' -f 2)) \
		docker build --build-arg TARGETOS=$(TARGETOS) --build-arg TARGETARCH=$(TARGETARCH) -t $(REGISTRY)/$(APP):$(VERSION)-$(TARGETOS)-$(TARGETARCH) . ;\
	done

push:
	for platform in $(PLATFORMS); do \
		$(eval TARGETOS=$(shell echo $$platform | cut -d '/' -f 1)) \
		$(eval TARGETARCH=$(shell echo $$platform | cut -d '/' -f 2)) \
		docker push $(REGISTRY)/$(APP):$(VERSION)-$(TARGETOS)-$(TARGETARCH) ;\
	done

clean:
	rm -rf $(BUILD_OUTPUT)
	for platform in $(PLATFORMS); do \
		$(eval TARGETOS=$(shell echo $$platform | cut -d '/' -f 1)) \
		$(eval TARGETARCH=$(shell echo $$platform | cut -d '/' -f 2)) \
		docker rmi $(REGISTRY)/$(APP):$(VERSION)-$(TARGETOS)-$(TARGETARCH) ;\
	done
