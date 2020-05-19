-- Tables for underlying text representation of downloaded tables

-- schema
CREATE TABLE gp_registrations_txt(
  "eid" INTEGER,
  "data_provider" INTEGER,
  "reg_date" TEXT,
  "deduct_date" TEXT
);

CREATE TABLE gp_clinical_txt(
  "eid" INTEGER,
  "data_provider" INTEGER,
  "event_dt" TEXT,
  "read_2" TEXT,
  "read_3" TEXT,
  "value1" TEXT,
  "value2" TEXT,
  "value3" TEXT
);

CREATE TABLE gp_scripts_txt(
 "eid" INTEGER,
 "data_provider" INTEGER,
 "issue_date" TEXT,
 "read_2" TEXT,
 "bnf_code" TEXT,
 "dmd_code" TEXT,
 "drug_name" TEXT,
 "quantity" TEXT
);

CREATE TABLE hesin_txt(
	"eid" INTEGER,
	"ins_index" INTEGER,
	"dsource" TEXT,
	"source" INTEGER,
	"epistart" TEXT,
	"epiend" TEXT,
	"epidur" INTEGER,
	"bedyear" INTEGER,
	"epistat" INTEGER,
	"epitype" INTEGER,
	"epiorder" INTEGER,
	"spell_index" INTEGER,
	"spell_seq" INTEGER,
	"spelbgin" INTEGER,
	"spelend" TEXT,
	"speldur" INTEGER,
	"pctcode" TEXT,
	"gpprpct" TEXT, 
	"category" INTEGER,
	"elecdate" TEXT,
	"elecdur" INTEGER,
	"admidate" TEXT,
	"admimeth_uni" INTEGER,
	"admimeth" INTEGER,
	"admisorc_uni" INTEGER,
	"admisorc" TEXT,
	"firstreg" INTEGER,
	"classpat_uni" INTEGER,
	"classpat" TEXT,
	"intmanag_uni" INTEGER,
	"intmanag" INTEGER,
	"mainspef_uni" INTEGER,
	"mainspef" TEXT,
	"tretspef_uni" INTEGER,
	"tretspef" TEXT,
	"operstat" INTEGER,
	"disdate" TEXT,
	"dismeth_uni" INTEGER,
	"dismeth" INTEGER,
	"disdest_uni" INTEGER,
	"disdest" INTEGER,
	"carersi" INTEGER,
	UNIQUE (eid, ins_index)
);

CREATE TABLE hesin_diag_txt(
	"eid" INTEGER,
	"ins_index" INTEGER,
	"arr_index" INTEGER,
	"level" INTEGER,
	"diag_icd9" TEXT,
	"diag_icd9_nb" TEXT,
	"diag_icd10" TEXT,
	"diag_icd10_nb" TEXT,
	UNIQUE (eid, ins_index, arr_index)
);

CREATE TABLE hesin_oper_txt(
	"eid"	INTEGER,
	"ins_index" INTEGER,
	"arr_index"	INTEGER,
	"level" INTEGER,
	"opdate" TEXT, 
	"oper3"	TEXT,
	"oper3_nb" TEXT,
	"oper4"	TEXT,
	"oper4_nb" TEXT,
	"posopdur" INTEGER,
	"preopdur" INTEGER,
	UNIQUE (eid, ins_index, arr_index)
);

CREATE TABLE hesin_psych_txt(
	"eid" INTEGER,
	"ins_index" INTEGER,
	"detncat" INTEGER,
	"detndate" TEXT,
	"mentcat" INTEGER,
	"admistat" INTEGER,
	"leglstat" INTEGER,
	UNIQUE (eid, ins_index)
);

CREATE TABLE hesin_maternity_txt(
	"eid" INTEGER,
	"ins_index" INTEGER,
	"numbaby" INTEGER,
	"numpreg" INTEGER,
	"anasdate" TEXT,
	"anagest" INTEGER,
	"antedur" INTEGER,
	"delinten" INTEGER,
	"delchang" INTEGER,
	"delprean" INTEGER,
	"delposan" INTEGER,
	"delonset" INTEGER,
	"postdur" INTEGER,
	"matage" INTEGER,
	UNIQUE(eid, ins_index)
);

CREATE TABLE hesin_delivery_txt(
	"eid" INTEGER,
	"ins_index" INTEGER,
	"arr_index" INTEGER,
	"gestat" INTEGER,
	"delplac" INTEGER,
	"delmeth" TEXT,
	"birordr" TEXT,
	"birstat" INTEGER,
	"biresus" INTEGER,
	"sexbaby" INTEGER,
	"birweight" INTEGER,
	"delstat" INTEGER,
	UNIQUE(eid, ins_index, arr_index)
);
