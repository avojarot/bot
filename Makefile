APP := $(shell basename $(shell git remote get-url origin))
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

# Визначення цільових платформ та архітектур
TARGETOS := linux darwin windows
TARGETARCH := amd64 arm64

# Стандартний формат, лінт та тестування
format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v ./...

# Функція для збірки під кожну платформу та архітектуру
define build_target
$(1)_$(2):
	GOOS=$(1) GOARCH=$(2) CGO_ENABLED=0 go build -o bin/$(APP)-$(1)-$(2) -ldflags "-X=github.com/$(APP)/cmd.appVersion=${VERSION}" ./...
endef

# Генерація цілей для кожної комбінації платформи та архітектури
$(foreach os,$(TARGETOS),$(foreach arch,$(TARGETARCH),$(eval $(call build_target,$(os),$(arch)))))

clean:
	rm -rf bin
	docker rmi $(REGISTRY)/$(APP):$(VERSION)-*

.PHONY: format lint test clean $(foreach os,$(TARGETOS),$(foreach arch,$(TARGETARCH),$(os)_$(arch)))
