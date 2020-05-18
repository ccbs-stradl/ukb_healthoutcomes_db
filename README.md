# UK Biobank Record Level Health-related Outcomes Database

Commands to load record-level access [Health-related outcomes](http://biobank.ndph.ox.ac.uk/showcase/label.cgi?id=3001) tables into an [SQLite](https://www.sqlite.org) database. Data must be requested from UK Biobank and downloaded as database tables from the Data Portal.

# Introduction

The health outcomes data tables in UKB can be upwards of 4GB in size and therefore can be memory-intensive to work with. My storing the data tables in a database, it is possible to query them without loading all of the data into memory.

## List of database tables

### [Hospital inpatient](http://biobank.ndph.ox.ac.uk/showcase/label.cgi?id=2000)

- `hesin`: Master table of administrative records
- `hesin_diag`: Diagnosis codes
- `hesin_oper`: Operations and procedural codes 
- `hesin_psych`: Administrative records relating to psychiatry
- `hesin_maternity`: Maternity records of care
- `hesin_delivery`: Children born as the result of a maternity record.

### [Primary care](http://biobank.ndph.ox.ac.uk/showcase/label.cgi?id=3001)

- `gp_clinical`: [GP clinical event records](http://biobank.ndph.ox.ac.uk/showcase/field.cgi?id=42040)
- `gp_scripts`: [GP prescription records](http://biobank.ndph.ox.ac.uk/showcase/field.cgi?id=42039)
- `gp_registrations`: [GP registration records](http://biobank.ndph.ox.ac.uk/showcase/field.cgi?id=42038)

## Downloading the database tables

Assuming you have requested the relevant fields for the record-level health outcomes data, the full database tables can be downloaded (in tab-separated text format) from the [UKB Data Showcase](http://biobank.ndph.ox.ac.uk/showcase/)

1. Log in to the [AMS Portal](https://bbams.ndph.ox.ac.uk/ams/)
2. Select the **Projects** tab
3. Click the "View/Update" button for the Application you are downloading data for
4. Select the **Data** tab.
5. Click the "Go to Showcase to refresh or download data" button.
6. Select the **Data Portal** tab.
7. Click the "Connect" button.
8. Select the **Table Download** tab.
9. Enter the name of a table (listed above) to download and click the "Fetch Table" button.
10. Use the `wget` command to download the table, or click the download link (`wget` is preferred as it names the file correctly. The download link may open the table directly in a browser window, in which case you have to use _Save as..._ to save it).

# Database creation

Move the downloaded text files into the repository directory. They are expected to have the names given to them in the `wget` command (of the form `table_name.txt`). If the tables have different names, are in different locations, or are not available, modify the `importdata.sql` file as appropriate.

Create the database file
```
sqlite3 healthoutcomes.db
```

In the `sqlite>` prompt, create the database tables and load the data:

```
.read createdb.sql
.read importdata.sql
.quit
```

# Working with the data

The data can be manipulated in R without loading the entire dataset into memory. There are several [R libraries for working with databases](https://db.rstudio.com) such as [RSQLite](https://cran.r-project.org/web/packages/RSQLite/index.html) and [dplyr](https://db.rstudio.com/dplyr/).

```
# install required packages
install.packages(c('dplyr', 'RSQLite', 'dbplyr'))

library(dplyr)

# make connection to database
con <- DBI::dbConnect(RSQLite::SQLite(), 'healthoutcomes.db')

# load hesin table
hesin <- tbl(con, 'hesin')
```

The `hesin` table can then be worked on using dplyr commands like any other `tibble`.

## Issues

### Missing data

Because of the way the way that SQLite can store mixed types in a column, some empty cells  are encoded as empty strings (`''`) rather than as `NULL`/`NA`. This shows up as the warning message

```
1: In result_fetch(res@ptr, n = n) :
  Column `COLUMN_NAME`: mixed type, first seen values of type integer, coercing other values of type string
```

When filtering in dplyr, use, e.g. `!=''` instead of `!is.na`. For example, find rows where spell duration is not missing

```
hesin %>% filter(speldur != '')
```

### Dates

Dates are encoded as strings of the format `YYYYMMDD` or `DD/MM/YYYY`.


### Codings

Many columns are stored as coded integers rather than strings. The [HES Data Dictionary](http://biobank.ndph.ox.ac.uk/showcase/refer.cgi?id=141140) lists the structure of each table and the data coding for each column. Data codings can be searched for on the [UKB Showcase](http://biobank.ndph.ox.ac.uk/showcase/search.cgi) and inspected or downloaded as a text file. For example, the `source` column of the `hesin` table has [Data-Coding 263](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=263).