#!/bin/bash
# Start SQL Server in the background
# /opt/mssql/bin/sqlservr &

# # Wait for SQL Server to be ready (up to 60 seconds)
# for i in {1..12}; do
#   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" && break || echo "Waiting for SQL Server (Attempt $i/12)..." && sleep 5
# done

# # Keep container running
# wait

#!/bin/bash
# Start SQL Server in the background
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to start
sleep 30s

# Create the database
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "CREATE DATABASE MyApiDb"

# Keep the container running
wait