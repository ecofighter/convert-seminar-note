FROM ghcr.io/ecofighter/uplatex-container:v1.0.2

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]