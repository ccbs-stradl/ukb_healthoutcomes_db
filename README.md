# UK Biobank Record Level Health-related Outcomes Database

Commands to load record-level access [Health-related outcomes](http://biobank.ndph.ox.ac.uk/showcase/label.cgi?id=3001) tables into an [SQLite](https://www.sqlite.org) database. Data must be requested from UK Biobank and downloaded as database tables from the Data Portal.

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

# Database creation

Create the database file
```
sqlite3 ukb_healthoutcomes.sql
```

In the `sqlite>` prompt, create the database tables, load the data, and create table views

```
.read createdb.sql
.read importdata.sql
.quit
```