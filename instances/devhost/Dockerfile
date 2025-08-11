FROM ubuntu:rolling

# Initialize
COPY scripts/init.sh /tmp/init.sh
RUN /tmp/init.sh && rm /tmp/init.sh

# Setup entrypoint  
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22

CMD ["/entrypoint.sh"]
