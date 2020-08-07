#!/bin/sh

# Create database schema
if [ -f healthoutcomes.db ]; then rm healthoutcomes.db; fi
  
# Load raw data
sqlite3 healthoutcomes.db < raw.sql
sqlite3 healthoutcomes.db < import.sql
sqlite3 healthoutcomes.db < gp.sql
sqlite3 healthoutcomes.db < hesin.sql
sqlite3 healthoutcomes.db < views.sql
sqlite3 healthoutcomes.db < index.sql
