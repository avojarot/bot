# Вибираємо платформу та архітектуру через аргументи
ARG TARGETOS=linux
ARG TARGETARCH=amd64

# Використовуємо відповідний базовий образ для компіляції
FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app
COPY . .

RUN make $(TARGETOS)_$(TARGETARCH)

# Використовуємо пустий базовий образ для мінімального розміру
FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/bin/$(APP)-$(TARGETOS)-$(TARGETARCH) /kbot
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/kbot", "start"]

# Дефолтні аргументи для збирання образу
ARG TARGETOS=linux
ARG TARGETARCH=amd64

# Збірка образу
FROM quay.io/projectquay/golang:1.20 as builder

WORKDIR /go/src/app
COPY . .

RUN make $(TARGETOS)_$(TARGETARCH)

# Використовуємо пустий базовий образ для мінімального розміру
FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/bin/$(APP)-$(TARGETOS)-$(TARGETARCH) /kbot
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["/kbot", "start"]
