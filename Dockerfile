FROM ghcr.io/ecofighter/uplatex-container:latest

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]