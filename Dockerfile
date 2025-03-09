# FROM mcr.microsoft.com/mssql/server:2019-latest

# # Set environment variables
# ENV ACCEPT_EULA=Y
# ENV SA_PASSWORD=odnc@#0f9df#@!@
# ENV MSSQL_PID=Express

# # Expose SQL Server port
# EXPOSE 1433

# # Add initialization script
# COPY ./init-db.sh /usr/local/bin/init-db.sh

# # Health check
# HEALTHCHECK --interval=10s --timeout=5s --retries=6 \
#   CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" || exit 1

# # Start SQL Server with init script
# CMD ["/usr/local/bin/init-db.sh"]

FROM mcr.microsoft.com/mssql/server:2019-latest

# Set environment variables
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=odnc@#0f9df#@!@
ENV MSSQL_PID=Express

# Expose SQL Server port
EXPOSE 1433

# Switch to root for permission changes
USER root

# Add initialization script and set permissions using UID/GID
COPY ./init-db.sh /usr/local/bin/init-db.sh
RUN chmod +x /usr/local/bin/init-db.sh && chown 10001:10001 /usr/local/bin/init-db.sh

# Switch back to mssql (optional, base image handles runtime user)
USER mssql

# Health check
HEALTHCHECK --interval=10s --timeout=5s --retries=6 \
  CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" || exit 1

# Start SQL Server with init script
CMD ["/usr/local/bin/init-db.sh"]