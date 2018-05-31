FROM gliderlabs/alpine:latest
ADD https://storage.googleapis.com/kubernetes-release/release/v1.10.2/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ADD https://s3cr3t.net/etcdctl /usr/local/bin/etcdctl
ADD https://git.io/vagrant_rsa /config/.ssh/vagrant_rsa
RUN addgroup -g 994 docker
RUN apk-install openssh-client docker tshark bash tmux screen iputils bind-tools curl ca-certificates
ENV HOME=/config
ENV ETCDCTL_API=3
RUN set -x && \
    chmod +x /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/etcdctl && \
    \
    adduser exploit -Du 1000 -h /config && \
    \

    # Basic check it works.
    kubectl version --client
CMD ["sleep", "86500"]
