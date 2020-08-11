-- Tables for normalized data
PRAGMA foreign_keys = ON;


 --
 -- GP Registrations
 --

BEGIN TRANSACTION;

CREATE TABLE gp_registrations_data(
  "id" INTEGER,
  "data_provider" INTEGER,
  "reg_date" TEXT,
  "deduct_date" TEXT,
  FOREIGN KEY (id) REFERENCES eids(id)
);

INSERT INTO gp_registrations_data
SELECT id,
     data_provider,
	   date(substr(reg_date, 7, 4) || '-' ||
	        substr(reg_date, 4, 2) || '-' ||
	        substr(reg_date, 1, 2)) AS reg_date,
	   date(substr(deduct_date, 7, 4) || '-' ||
		    substr(deduct_date, 4, 2) || '-' ||
		    substr(deduct_date, 1, 2)) AS deduct_date
FROM
gp_registrations_txt
LEFT JOIN eids USING (eid);

DROP TABLE gp_registrations_txt;

COMMIT;

--
-- GP Clinical Records
--

BEGIN TRANSACTION;

-- Read codes
CREATE TABLE gp_clinical_read_2(
  read_2_id INTEGER PRIMARY KEY,
  read_2 TEXT,
  UNIQUE (read_2)
);

-- Insert list of unique read_2 codes into the table
-- the NULL in the first column of the select prompts the
-- gp_clinical_read_2 table to create a primary key
INSERT INTO gp_clinical_read_2 
SELECT DISTINCT NULL, read_2 FROM gp_clinical_txt
WHERE read_2 IS NOT '';

-- Read 3
CREATE TABLE gp_clinical_read_3(
  read_3_id INTEGER PRIMARY KEY,
  read_3 TEXT,
  UNIQUE (read_3)
);
-- Insert unique read 3 codes
INSERT INTO gp_clinical_read_3 
SELECT DISTINCT NULL, read_3 FROM gp_clinical_txt
WHERE read_3 IS NOT '';


-- Clinical data
-- Hold clinical data with references to EIDs and read codes

CREATE TABLE gp_clinical_data(
  id INTEGER,
  data_provider INTEGER,
  event_dt TEXT,
  read_2_id INTEGER,
  read_3_id INTEGER,
  value1 TEXT,
  value2 TEXT,
  value3 TEXT,
  FOREIGN KEY (id) REFERENCES eids(id),
  FOREIGN KEY (read_2_id) REFERENCES gp_clinical_read_2(read_2_id),
  FOREIGN KEY (read_3_id) REFERENCES gp_clinical_read_3(read_3_id)
);

INSERT INTO gp_clinical_data
SELECT
  id, data_provider,
  date(substr(event_dt, 7, 4) || '-' ||
	     substr(event_dt, 4, 2) || '-' ||
	     substr(event_dt, 1, 2)) AS event_dt,
  read_2_id, read_3_id,
  value1, value2, value3
FROM
gp_clinical_txt
LEFT JOIN eids USING (eid)
LEFT JOIN gp_clinical_read_2 USING (read_2)
LEFT JOIN gp_clinical_read_3 USING (read_3);

DROP TABLE gp_clinical_txt;

COMMIT;

--
-- GP Prescribing Records
--

BEGIN TRANSACTION;

-- Read, BNF, and DM+D codes and drug names

-- Read 2 codes
CREATE TABLE gp_scripts_read_2(
  read_2_id INTEGER PRIMARY KEY,
  read_2 TEXT,
  UNIQUE(read_2)
);
-- insert unique list of codes
INSERT INTO gp_scripts_read_2 
SELECT DISTINCT NULL, read_2 FROM gp_scripts_txt
WHERE read_2 IS NOT '';

-- British National Formulary codes
CREATE TABLE gp_scripts_bnf_code(
  bnf_code_id INTEGER PRIMARY KEY,
  bnf_code TEXT,
  UNIQUE(bnf_code)
);
-- unique list of BNF codes
INSERT INTO gp_scripts_bnf_code 
SELECT DISTINCT NULL, bnf_code FROM gp_scripts_txt
WHERE bnf_code IS NOT '';

-- Dictionary of medicines and devices codes
CREATE TABLE gp_scripts_dmd_code(
  dmd_code_id INTEGER PRIMARY KEY,
  dmd_code TEXT,
  UNIQUE(dmd_code)
);
-- unique list of codes
INSERT INTO gp_scripts_dmd_code 
SELECT DISTINCT NULL, dmd_code FROM gp_scripts_txt
WHERE dmd_code IS NOT '';

-- Drug names
CREATE TABLE gp_scripts_drug_name(
  drug_name_id INTEGER PRIMARY KEY,
  drug_name TEXT,
  UNIQUE(drug_name)
);
-- unique list of drug names
INSERT INTO gp_scripts_drug_name 
SELECT DISTINCT NULL, drug_name FROM gp_scripts_txt
WHERE drug_name IS NOT '';

-- Prescribing code combinations
CREATE TABLE gp_scripts_codes(
  codes_id INTEGER PRIMARY KEY,
  read_2_id INTEGER,
  bnf_code_id INTEGER,
  dmd_code_id INTEGER,
  drug_name_id INTEGER,
  FOREIGN KEY (read_2_id) REFERENCES gp_scripts_read_2(read_2_id),
  FOREIGN KEY (bnf_code_id) REFERENCES gp_scripts_bnf_code(bnf_code_id),
  FOREIGN KEY (dmd_code_id) REFERENCES gp_scripts_dmd_code(dmd_code_id),
  FOREIGN KEY (drug_name_id) REFERENCES gp_scripts_drug_name(drug_name_id),
  UNIQUE(read_2_id, bnf_code_id, dmd_code_id, drug_name_id)
);

INSERT INTO gp_scripts_codes
SELECT DISTINCT NULL, read_2_id, bnf_code_id, dmd_code_id, drug_name_id
FROM gp_scripts_txt
LEFT JOIN gp_scripts_read_2 USING (read_2)
LEFT JOIN gp_scripts_bnf_code USING (bnf_code)
LEFT JOIN gp_scripts_dmd_code USING (dmd_code)
LEFT JOIN gp_scripts_drug_name USING (drug_name);

-- Prescribing data with references to EIDs and drug codes
CREATE TABLE gp_scripts_data(
 id INTEGER,
 data_provider INTEGER,
 issue_date TEXT,
 codes_id INTEGER,
 quantity TEXT,
 FOREIGN KEY (id) REFERENCES eids(id)
 FOREIGN KEY (codes_id) REFERENCES gp_scripts_codes(codes_id)
);

-- Use drug codes to look up unique combinations of codes to
-- get code id
INSERT INTO gp_scripts_data
SELECT id, data_provider,
  date(substr(issue_date, 7, 4) || '-' ||
  	 substr(issue_date, 4, 2) || '-' ||
  	 substr(issue_date, 1, 2)) AS issue_date,
     codes_id,
     quantity
FROM gp_scripts_txt
LEFT JOIN eids USING(eid)
LEFT JOIN gp_scripts_read_2 USING (read_2)
LEFT JOIN gp_scripts_bnf_code USING (bnf_code)
LEFT JOIN gp_scripts_dmd_code USING (dmd_code)
LEFT JOIN gp_scripts_drug_name USING (drug_name)
LEFT JOIN gp_scripts_codes USING (read_2_id, bnf_code_id, dmd_code_id, drug_name_id);

DROP TABLE gp_scripts_txt;

COMMIT;



