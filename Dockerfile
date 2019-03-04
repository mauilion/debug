FROM gliderlabs/alpine:latest
COPY --from=gcr.io/etcd-development/etcd /usr/local/bin/etcdctl /usr/local/bin/etcdctl

COPY --from=bitnami/kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl

COPY --from=jpetazzo/nsenter /. /usr/local/bin/

COPY --from=quay.io/mauilion/echo-server /bin/echo-server /bin/echo-server
ENV PORT 8080
ENV SSLPORT 8443
EXPOSE 8080 8443
ENV ADD_HEADERS='{"X-Real-Server": "echo-server"}'
RUN apk-install openssl iproute2 openssh-client sudo docker tshark bash bash-completion tmux screen iputils bind-tools curl ca-certificates
RUN set -x && \
    chmod +x /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/etcdctl && \
    chmod +x /bin/echo-server && \
    kubectl version --client
CMD ["/bin/echo-server"]
