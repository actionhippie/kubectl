FROM alpine:3.24@sha256:c6b073f8e9e58d881f6ffba6ebf3b9ebd60b9e7d6e8337018c0e68bb5c356873 AS build

# renovate: datasource=github-releases depName=kubernetes/kubernetes
ENV KUBECTL_VERSION=1.37.1

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

FROM alpine:3.24@sha256:c6b073f8e9e58d881f6ffba6ebf3b9ebd60b9e7d6e8337018c0e68bb5c356873

RUN apk add --no-cache bash

ENTRYPOINT ["/usr/local/bin/entrypoint"]
COPY overlay /
COPY --from=build /tmp/kubectl /usr/bin/kubectl
