#!/bin/sh

# Create database schema
if [ -f healthoutcomes.db ]; then rm healthoutcomes.db; fi
  
echo "Creating import schema"
sqlite3 healthoutcomes.db < raw.sql

echo "Importing raw data"
sqlite3 healthoutcomes.db < import.sql

echo "Structuring GP records"
sqlite3 healthoutcomes.db < gp.sql

echo "Structuring HES records"
sqlite3 healthoutcomes.db < hesin.sql

echo "Creating end user views"
sqlite3 healthoutcomes.db < views.sql

echo "Indexing tables"
sqlite3 healthoutcomes.db < index.sql
