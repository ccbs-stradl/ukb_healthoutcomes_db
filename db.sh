#!/bin/sh

# Create database schema
if [ -f healthoutcomes.db ]; then rm healthoutcomes.db; fi
  
echo "Creating import schema"
sqlite3 healthoutcomes.db < schema/raw.sql

echo "Importing raw data"
sqlite3 healthoutcomes.db < schema/import.sql

echo "Structuring GP records"
sqlite3 healthoutcomes.db < schema/gp.sql

echo "Structuring HES records"
sqlite3 healthoutcomes.db < schema/hesin.sql

echo "Creating end user views"
sqlite3 healthoutcomes.db < schema/views.sql

echo "Indexing tables"
sqlite3 healthoutcomes.db < schema/index.sql

echo "Analysing database"
sqlite3 healthoutcomes.db < schema/analyse.sql
