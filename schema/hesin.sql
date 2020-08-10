-- Tables for normalized data
PRAGMA foreign_keys = ON;

--
-- Hospital Episode Statistics
--

--
-- Main table
--

CREATE TABLE hesin_dsource(
  dsource_id INTEGER PRIMARY KEY,
  dsource TEXT,
  UNIQUE(dsource)
);
INSERT INTO hesin_dsource
  SELECT DISTINCT NULL, dsource from hesin_txt;

CREATE TABLE hesin_pctcode(
  pctcode_id INTEGER PRIMARY KEY,
  pctcode TEXT,
  UNIQUE(pctcode)
);
INSERT INTO hesin_pctcode
  SELECT DISTINCT NULL, pctcode from hesin_txt
  WHERE pctcode IS NOT '';

CREATE TABLE hesin_gpprpct(
  gpprpct_id INTEGER PRIMARY KEY,
  gpprpct TEXT,
  UNIQUE(gpprpct)
);
INSERT INTO hesin_gpprpct
  SELECT DISTINCT NULL, gpprpct from hesin_txt
  WHERE gpprpct IS NOT '';


CREATE TABLE hesin_classpat(
  classpat_id INTEGER PRIMARY KEY,
  classpat TEXT,
  UNIQUE(classpat)
);
INSERT INTO hesin_classpat
  SELECT DISTINCT NULL, classpat from hesin_txt
  WHERE classpat IS NOT '';

CREATE TABLE hesin_mainspef(
  mainspef_id INTEGER PRIMARY KEY,
  mainspef TEXT,
  UNIQUE(mainspef)
);
INSERT INTO hesin_mainspef
  SELECT DISTINCT NULL, mainspef from hesin_txt
  WHERE mainspef IS NOT '';

CREATE TABLE hesin_tretspef(
  tretspef_id INTEGER PRIMARY KEY,
  tretspef TEXT,
  UNIQUE(tretspef)
);
INSERT INTO hesin_tretspef
  SELECT DISTINCT NULL, tretspef from hesin_txt
  WHERE tretspef IS NOT '';


CREATE TABLE hesin_data(
  id INTEGER,
  ins_index INTEGER,
  dsource_id INTEGER,
  source INTEGER,
  epistart TEXT,
  epiend TEXT,
  epidur INTEGER,
  bedyear INTEGER,
  epistat INTEGER,
  epitype INTEGER,
  epiorder INTEGER,
  spell_index INTEGER,
  spell_seq INTEGER,
  spelbgin INTEGER,
  spelend TEXT,
  speldur INTEGER,
  pctcode_id INTEGER,
  gpprpct_id INTEGER,
  category INTEGER,
  elecdate TEXT,
  elecdur INTEGER,
  admidate TEXT,
  admimeth_uni INTEGER,
  admimeth INTEGER,
  admisorc_uni INTEGER,
  admisorc INTEGER,
  firstreg INTEGER,
  classpat_uni INTEGER,
  classpat_id INTEGER,
  intmanag_uni INTEGER,
  intmanag INTEGER,
  mainspef_uni INTEGER,
  mainspef_id INTEGER,
  tretspef_uni INTEGER,
  tretspef_id INTEGER,
  operstat INTEGER,
  disdate TEXT,
  dismeth_uni INTEGER,
  dismeth INTEGER,
  disdest_uni INTEGER,
  disdest INTEGER,
  carersi INTEGER,
  UNIQUE(id, ins_index),
  FOREIGN KEY (id) REFERENCES eids(id),
  FOREIGN KEY (dsource_id) REFERENCES hesin_dsource(dsource_id),
  FOREIGN KEY (pctcode_id) REFERENCES hesin_pctcode(pctcode_id),
  FOREIGN KEY (gpprpct_id) REFERENCES hesin_gpprpct(gpprpct_id),
  FOREIGN KEY (classpat_id) REFERENCES hesin_classpat(classpat_id),
  FOREIGN KEY (mainspef_id) REFERENCES hesin_mainspef(mainspef_id),
  FOREIGN KEY (tretspef_id) REFERENCES hesin_tretspef(tretspef_id)
);


INSERT INTO hesin_data
  SELECT
  id, ins_index, dsource_id, source,
  	date(substr(epistart, 1, 4) || '-' ||
  	     substr(epistart, 5, 2) || '-' ||
  	     substr(epistart, 7, 2)) AS epistart,
  	date(substr(epiend, 1, 4) || '-' ||
  		   substr(epiend, 5, 2) || '-' ||
  		   substr(epiend, 7, 2)) AS epiend,
  epidur, bedyear, epistat, epitype, epiorder,
  spell_index, spell_seq, spelbgin, spelend, speldur,
  pctcode_id, gpprpct_id, category,
  	date(substr(elecdate, 1, 4) || '-' ||
  	     substr(elecdate, 5, 2) || '-' ||
  	     substr(elecdate, 7, 2)) AS elecdate,
  	elecdur,
  	date(substr(admidate, 1, 4) || '-' ||
         substr(admidate, 5, 2) || '-' ||
         substr(admidate, 7, 2)) AS admidate,
  admimeth_uni, admimeth, admisorc_uni, admisorc,
  firstreg, classpat_uni, classpat_id, intmanag_uni, intmanag,
  mainspef_uni, mainspef_id, tretspef_uni, tretspef_id, operstat,
  	date(substr(disdate, 1, 4) || '-' ||
  		   substr(disdate, 5, 2) || '-' ||
  		   substr(disdate, 7, 2)) AS disdate,
  dismeth_uni, dismeth, disdest_uni, disdest, carersi
  FROM
  hesin_txt
  LEFT JOIN eids           USING (eid)         
  LEFT JOIN hesin_dsource  USING (dsource) 
  LEFT JOIN hesin_pctcode  USING (pctcode) 
  LEFT JOIN hesin_gpprpct  USING (gpprpct)
  LEFT JOIN hesin_classpat USING (classpat)
  LEFT JOIN hesin_mainspef USING (mainspef)
  LEFT JOIN hesin_tretspef USING (tretspef);


--
-- ICD Diagnoses
--


CREATE TABLE hesin_diag_icd9(
  diag_icd9_id INTEGER PRIMARY KEY,
  diag_icd9 TEXT,
  UNIQUE(diag_icd9)
);
INSERT INTO hesin_diag_icd9
  SELECT DISTINCT NULL, diag_icd9 from hesin_diag_txt
  WHERE diag_icd9 IS NOT '';

CREATE TABLE hesin_diag_icd10(
  diag_icd10_id INTEGER PRIMARY KEY,
  diag_icd10 TEXT,
  UNIQUE(diag_icd10)
);
INSERT INTO hesin_diag_icd10
  SELECT DISTINCT NULL, diag_icd10 from hesin_diag_txt
  WHERE diag_icd10 IS NOT '';


CREATE TABLE hesin_diag_data(
  id INTEGER,
  ins_index INTEGER,
  arr_index INTEGER,
  level INTEGER,
  diag_icd9_id INTEGER,
  diag_icd9_nb TEXT,
  diag_icd10_id INTEGER,
  diag_icd10_nb TEXT,
  UNIQUE (id, ins_index, arr_index),
  FOREIGN KEY (id) REFERENCES eids(id),
  FOREIGN KEY (diag_icd9_id) REFERENCES hesin_diag_icd9(diag_icd9_id),
  FOREIGN KEY (diag_icd10_id) REFERENCES hesin_diag_icd10(diag_icd10_id)
);

INSERT INTO hesin_diag_data
  SELECT
    id,
    ins_index,
    arr_index,
    level,
    diag_icd9_id,
    diag_icd9_nb,
    diag_icd10_id,
    diag_icd10_nb
  FROM hesin_diag_txt
  LEFT JOIN eids USING(eid)
  LEFT JOIN hesin_diag_icd9 USING(diag_icd9)
  LEFT JOIN hesin_diag_icd10 USING(diag_icd10);

--
-- Operations
--

CREATE TABLE hesin_oper3(
  oper3_id INTEGER PRIMARY KEY,
  oper3 TEXT,
  UNIQUE(oper3)
);
INSERT INTO hesin_oper3
  SELECT DISTINCT NULL, oper3 from hesin_oper_txt
  WHERE oper3 IS NOT '';
  
CREATE TABLE hesin_oper4(
  oper4_id INTEGER PRIMARY KEY,
  oper4 TEXT,
  UNIQUE(oper4)
);
INSERT INTO hesin_oper4
  SELECT DISTINCT NULL, oper4 from hesin_oper_txt
  WHERE oper4 IS NOT '';

CREATE TABLE hesin_oper_data(
  id  INTEGER,
  ins_index INTEGER,
  arr_index  INTEGER,
  level INTEGER,
  opdate TEXT,
  oper3_id  INTEGER,
  oper3_nb TEXT,
  oper4_id  INTEGER,
  oper4_nb TEXT,
  posopdur INTEGER,
  preopdur INTEGER,
  UNIQUE (id, ins_index, arr_index)
  FOREIGN KEY (id) REFERENCES eids(id),
  FOREIGN KEY (oper3_id) REFERENCES hesin_oper3(oper3_id),
  FOREIGN KEY (oper4_id) REFERENCES hesin_oper4(oper4_id)
);
  
INSERT INTO hesin_oper_data
  SELECT
   id, ins_index, arr_index, level,
   date(substr(opdate, 7, 4) || '-' ||
   	    substr(opdate, 4, 2) || '-' ||
  	    substr(opdate, 1, 2)) AS opdate,
   oper3_id, oper3_nb,
   oper4_id, oper4_nb,
   posopdur, preopdur
  FROM
  hesin_oper_txt
  LEFT JOIN eids USING(eid)
  LEFT JOIN hesin_oper3 USING(oper3)
  LEFT JOIN hesin_oper4 USING(oper4);


CREATE TABLE hesin_psych_data(
  id INTEGER,
  ins_index INTEGER,
  detncat INTEGER,
  detndate TEXT,
  mentcat INTEGER,
  admistat INTEGER,
  leglstat INTEGER,
  UNIQUE (id, ins_index)
  FOREIGN KEY (id) REFERENCES eids(id)
);


--
-- Psychiatric
--

INSERT INTO hesin_psych_data
SELECT
 id, ins_index, detncat,
 date(substr(detndate, 7, 4) || '-' ||
 	    substr(detndate, 4, 2) || '-' ||
	    substr(detndate, 1, 2)) AS detndate,
 mentcat, admistat, leglstat
FROM
hesin_psych_txt
LEFT JOIN eids USING(eid);

--
-- Maternity
--

CREATE TABLE hesin_maternity_data(
  id INTEGER,
  ins_index INTEGER,
  numbaby INTEGER,
  numpreg INTEGER,
  anasdate TEXT,
  anagest INTEGER,
  antedur INTEGER,
  delinten INTEGER,
  delchang INTEGER,
  delprean INTEGER,
  delposan INTEGER,
  delonset INTEGER,
  postdur INTEGER,
  matage INTEGER,
  UNIQUE(id, ins_index)
  FOREIGN KEY (id) REFERENCES eids(id)
);

INSERT INTO hesin_maternity_data
SELECT
 id, ins_index, numbaby, numpreg,
 date(substr(anasdate, 7, 4) || '-' ||
 	    substr(anasdate, 4, 2) || '-' ||
	    substr(anasdate, 1, 2)) AS anasdate,
anagest, antedur, delinten, delchang, delprean, delposan, delonset, postdur, matage
FROM
hesin_maternity_txt
LEFT JOIN eids USING(eid);


--
-- Delivery
--

CREATE TABLE hesin_delivery_data(
  id INTEGER,
  ins_index INTEGER,
  arr_index INTEGER,
  gestat INTEGER,
  delplac INTEGER,
  delmeth TEXT,
  birordr TEXT,
  birstat INTEGER,
  biresus INTEGER,
  sexbaby INTEGER,
  birweight INTEGER,
  delstat INTEGER,
  UNIQUE(id, ins_index, arr_index)
  FOREIGN KEY (id) REFERENCES eids(id)
);

INSERT INTO hesin_delivery_data
SELECT
id,
ins_index,
arr_index,
gestat,
delplac,
delmeth,
birordr,
birstat,
biresus,
sexbaby,
birweight,
delstat
FROM hesin_delivery_txt
LEFT JOIN eids USING(eid);


---
--- Clean up raw data
---

DROP TABLE hesin_txt;
DROP TABLE hesin_diag_txt;
DROP TABLE hesin_oper_txt;
DROP TABLE hesin_psych_txt;
DROP TABLE hesin_maternity_txt;
DROP TABLE hesin_delivery_txt;