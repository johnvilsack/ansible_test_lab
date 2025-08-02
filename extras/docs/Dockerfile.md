# The Image
FROM 

# Internal build commands
RUN 

# Port setup
EXPOSE 22

# Run entrypoint script every time - can be overridden withdocker run image other-command
CMD ["/entrypoint.sh"]

# Make an ENTRYPOINT - not easily overridden
ENTRYPOINT [ "executable" ]
