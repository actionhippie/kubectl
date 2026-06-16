FROM alpine:3.24@sha256:f5064d3e5f88c467c714509f491853ab2d951932c5cad699c0cb969dcec6f3b4 AS build

# renovate: datasource=github-releases depName=kubernetes/kubernetes
ENV KUBECTL_VERSION=1.36.2

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

FROM alpine:3.24@sha256:f5064d3e5f88c467c714509f491853ab2d951932c5cad699c0cb969dcec6f3b4

RUN apk add --no-cache bash

ENTRYPOINT ["/usr/local/bin/entrypoint"]
COPY overlay /
COPY --from=build /tmp/kubectl /usr/bin/kubectl
