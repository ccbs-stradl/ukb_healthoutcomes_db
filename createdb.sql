-- Import record-level tables

-- schema
CREATE TABLE gp_registrations(
  "eid" INTEGER,
  "data_provider" INTEGER,
  "reg_date" TEXT,
  "deduct_date" TEXT
);

CREATE TABLE gp_clinical(
  "eid" INTEGER,
  "data_provider" INTEGER,
  "event_dt" TEXT,
  "read_2" TEXT,
  "read_3" TEXT,
  "value1" TEXT,
  "value2" TEXT,
  "value3" TEXT
);

CREATE TABLE gp_scripts(
 "eid" INTEGER,
 "data_provider" INTEGER,
 "issue_date" TEXT,
 "read_2" TEXT,
 "bnf_code" TEXT,
 "dmd_code" TEXT,
 "drug_name" TEXT,
 "quantity" TEXT
);

