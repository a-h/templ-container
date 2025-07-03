# syntax=docker/dockerfile:1

FROM golang:1.24

# Install templ.
ARG TARGETARCH
RUN apt-get update && apt-get install -y curl tar \
 && curl -L "https://github.com/a-h/templ/releases/download/v0.3.906/templ_Linux_${TARGETARCH}.tar.gz" \
 | tar -xz -C /usr/local/bin \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Get the modules.
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . ./

# Build the app.
RUN templ generate && CGO_ENABLED=0 GOOS=linux go build -o /entrypoint

# Application.
EXPOSE 8080

# templ proxy.
EXPOSE 7331

ENTRYPOINT ["/entrypoint"]
