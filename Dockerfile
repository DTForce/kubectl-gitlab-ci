FROM alpine:3.20

ARG HELM_VERSION=3.16.3
ARG KUBECTL_VERSION=1.31.3

# Install kubectl
# Note: Latest version may be found on:
# https://aur.archlinux.org/packages/kubectl-bin/
ADD https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

ENV HOME=/config

RUN apk add --no-cache curl ca-certificates bash sed libintl perl-utils git && \
  apk add --no-cache --virtual build_deps gettext openssl  && \
  cp /usr/bin/envsubst /usr/local/bin/envsubst && \
  chmod +x /usr/local/bin/kubectl && \
  adduser kubectl -Du 2342 -h /config && \
  kubectl version --client && \
  wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
  tar -xvf helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
  cp linux-amd64/helm /usr/local/bin/ && \
  helm version && \
  apk del build_deps

USER kubectl

