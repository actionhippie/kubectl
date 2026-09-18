FROM alpine:3.24@sha256:e7c4abb69531cb09e2a2bbb56fad3367ab694865c49df898c1c683185cc4376c AS build

# renovate: datasource=github-releases depName=kubernetes/kubernetes
ENV KUBECTL_VERSION=1.37.0

ARG TARGETARCH

RUN apk add --no-cache curl && \
    case "${TARGETARCH}" in \
    'amd64') \
        curl -sSLo /tmp/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl; \
        ;; \
    'arm64') \
        curl -sSLo /tmp/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/arm64/kubectl; \
        ;; \
    *) echo >&2 "error: unsupported architecture '${TARGETARCH}'"; exit 1 ;; \
    esac && \
    chmod +x /tmp/kubectl

FROM alpine:3.24@sha256:e7c4abb69531cb09e2a2bbb56fad3367ab694865c49df898c1c683185cc4376c

RUN apk add --no-cache bash

ENTRYPOINT ["/usr/local/bin/entrypoint"]
COPY overlay /
COPY --from=build /tmp/kubectl /usr/bin/kubectl
