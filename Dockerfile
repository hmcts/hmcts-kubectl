FROM debian:13-slim AS builder

RUN apt-get update && \
    apt-get install -y curl ca-certificates gnupg apt-transport-https

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# Copy your app build/install steps here if needed

FROM hmctsprod.azurecr.io/imported/distroless/base-debian13:latest

COPY --from=builder /usr/local/bin/kubectl /usr/local/bin/kubectl
