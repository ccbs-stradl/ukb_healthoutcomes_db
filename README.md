# UK Biobank Record Level Health-related Outcomes Database Tools

Commands to load record-level access [Health-related outcomes](http://biobank.ndph.ox.ac.uk/showcase/label.cgi?id=3001) tables into an [SQLite](https://www.sqlite.org) database. Data must be requested from UK Biobank and downloaded as database tables from the Data Portal.

# Introduction

The health outcomes data tables in UKB can each be upwards of 4GB in size and therefore are memory-intensive to work with. By storing the data tables in a database, it is possible to query them without loading all of the data into memory.

### Updates

- Aug 10 2020: Database schema has been [normalised](https://en.wikipedia.org/wiki/Database_normalization) which shoud make many queries a lot faster, particularly those that involve searching text fields. It also decreases the size of the database by about 7GB.

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


## Installation

- Install [SQLite](https://www.sqlite.org/download.html) version > 3.9.0
- Clone the repository
  ```
  git clone git@github.com:ccbs-stradl/ukb_healthoutcomes_db.git
  cd ukb_healthoutcomes_db
  ```

## Downloading the database tables

Assuming you have requested the relevant fields for the record-level health outcomes data as part of an approved UKB application, the full database tables can be downloaded (in tab-separated text format) from the [UKB Data Showcase](http://biobank.ndph.ox.ac.uk/showcase/)

1. Log in to the [AMS Portal](https://bbams.ndph.ox.ac.uk/ams/)
2. Select the **Projects** tab
3. Click the "View/Update" button for the Application you are downloading data for
4. Select the **Data** tab.
5. Click the "Go to Showcase to refresh or download data" button.
6. Select the **Data Portal** tab.
7. Click the "Connect" button.
8. Select the **Table Download** tab.
9. Enter the name of a table (listed above) to download and click the "Fetch Table" button.
10. Use the listed `wget` command with the specified URL key to download the table, or click the download link (`wget` is preferred as it names the file correctly. The download link may open the table directly in a browser window, in which case you have to use _Save as..._ to save it).

```
wget -nd -Ohesin.txt https://biota.ndph.ox.ac.uk/...
wget -nd -Ohesin_diag.txt https://biota.ndph.ox.ac.uk/...
wget -nd -Ohesin_oper.txt https://biota.ndph.ox.ac.uk/...
wget -nd -Ohesin_psych.txt https://biota.ndph.ox.ac.uk/...
wget -nd -Ohesin_maternity.txt https://biota.ndph.ox.ac.uk/...
wget -nd -Ohesin_delivery.txt https://biota.ndph.ox.ac.uk/...
wget -nd -Ogp_clinical.txt https://biota.ndph.ox.ac.uk/...
wget -nd -Ogp_scripts.txt https://biota.ndph.ox.ac.uk/...
wget -nd -Ogp_registrations.txxt https://biota.ndph.ox.ac.uk/...
```

# Database creation

Move the downloaded text files into the repository directory. They are expected to have the names given to them in the `wget` command (of the form `table_name.txt`). If the tables have different names, are in different locations, or are not available, modify the `import.sql` file as appropriate.  

Create the database with
```
sh db.sh
```

The database creation script reads the raw data into the database and then [normalises](https://en.wikipedia.org/wiki/Database_normalization) it into a more compact set of tables to speed up querying.


The database is called `healthoutcomes.db` and can be opened using SQLite:

```
sqlite3 healthoutcomes.db
```

The database has end-user views of the data that conform to the table names and columns of the original data. Dates in the tables are standardised to the format `YYYY-MM-DD`.

The total size of the SQL database file is approximately XXGB (XXGB of data and XXGB of indices).

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

The `hesin` table can then be worked on using dplyr commands like any other `tibble`. Use `select()`, `filter()`, and `summarize()` commands to identify the subset of the data, or transform it by passing expressions with SQL functions to `mutate()`. Once your query is finalized together, use `collect()` to import the query into the R workspace for further manipulation or modeling. 

## Date information

The health outcomes data tables have date information formatted as either `YYYYMMDD` or `DD-MM-YYYY` so these have been normalized to `YYYY-MM-DD` so that they can be passed to [SQLite's date functions](https://www.sqlite.org/lang_datefunc.html). 

```
gp_registrations <- tbl(con, 'gp_registrations')
gp_clinical <- tbl(con, 'gp_clinical')

# Return all registrations from October 2016
gp_registrations %>% filter(reg_date >= '2016-10-1' & reg_date <= '2016-10-31') %>% arrange(reg_date)

# count how many clinical records are available for each year
gp_clinical %>% group_by(date(event_dt, 'start of year')) %>% tally()

``` 


## Searching by Drug Name

Prescriptions are referred to in `gp_scripts` table are variously coded with Read v2, BNF, or DMD codes depending on the data source. Many entries also have a plain text name of the drug in the `drug_name` column (along with dosage size information). The drug name can be searched using the `%LIKE%` operator and with the name of the drug surrounded by `"%%"`.

```

gp_scripts <- tbl(con, 'gp_scripts')
gp_scripts %>% filter(drug_name %LIKE% "%Amitriptyline%") 

```

## Issues


### Codings

Many columns are stored as coded integers rather than strings. The [HES Data Dictionary](http://biobank.ndph.ox.ac.uk/showcase/refer.cgi?id=141140) lists the structure of each table and the data coding for each column. Data codings can be searched for on the [UKB Showcase](http://biobank.ndph.ox.ac.uk/showcase/search.cgi) and inspected or downloaded as a text file. For example, the `source` column of the `hesin` table has [Data-Coding 263](http://biobank.ndph.ox.ac.uk/showcase/coding.cgi?id=263).



