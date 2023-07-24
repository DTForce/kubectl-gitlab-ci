FROM alpine:3.18

# Install kubectl
# Note: Latest version may be found on:
# https://aur.archlinux.org/packages/kubectl-bin/
ADD https://storage.googleapis.com/kubernetes-release/release/v1.27.4/bin/linux/amd64/kubectl /usr/local/bin/kubectl

ENV HOME=/config

RUN apk add --no-cache curl ca-certificates bash sed libintl perl-utils && \
  apk add --no-cache --virtual build_deps gettext openssl  && \
  cp /usr/bin/envsubst /usr/local/bin/envsubst && \
  chmod +x /usr/local/bin/kubectl && \
  adduser kubectl -Du 2342 -h /config && \
  kubectl version --client && \
  wget https://get.helm.sh/helm-v3.12.2-linux-amd64.tar.gz && \
  tar -xvf helm-v3.12.2-linux-amd64.tar.gz && \
  cp linux-amd64/helm /usr/local/bin/ && \
  helm version && \
  apk del build_deps

USER kubectl

