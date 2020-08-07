-- views reproducing the original non-normalised data


CREATE VIEW gp_registrations AS
SELECT eid, data_provider,
	   reg_date, deduct_date
FROM
gp_registrations_data
LEFT JOIN eids USING (id);

CREATE VIEW gp_clinical AS
SELECT
  eid, data_provider, event_dt,
  read_2, read_3, value1, value2, value3
FROM
gp_clinical_data
LEFT JOIN eids USING (id)
LEFT JOIN gp_clinical_read_2 USING (read_2_id)
LEFT JOIN gp_clinical_read_3 USING (read_3_id);

CREATE VIEW gp_scripts AS
SELECT
 eid, data_provider, issue_date,
 read_2, bnf_code, dmd_code, drug_name, quantity
FROM
gp_scripts_data
LEFT JOIN eids USING(id)
LEFT JOIN gp_scripts_codes USING (codes_id)
LEFT JOIN gp_scripts_read_2 USING (read_2_id)
LEFT JOIN gp_scripts_bnf_code USING (bnf_code_id)
LEFT JOIN gp_scripts_dmd_code USING (dmd_code_id)
LEFT JOIN gp_scripts_drug_name USING (drug_name_id);


CREATE VIEW hesin AS
SELECT
eid, ins_index, dsource, source,
epistart, epiend, epidur, bedyear, epistat, epitype, epiorder,
spell_index, spell_seq, spelbgin, spelend, speldur,
pctcode, gpprpct, category,
elecdate, elecdur,
admidate, admimeth_uni, admimeth, admisorc_uni, admisorc,
firstreg, classpat_uni, classpat, intmanag_uni, intmanag,
mainspef_uni, mainspef, tretspef_uni, tretspef, operstat,
disdate, dismeth_uni, dismeth, disdest_uni, disdest, carersi
FROM
hesin_data
LEFT JOIN eids           USING (id)         
LEFT JOIN hesin_dsource  USING (dsource_id) 
LEFT JOIN hesin_pctcode  USING (pctcode_id) 
LEFT JOIN hesin_gpprpct  USING (gpprpct_id)
LEFT JOIN hesin_classpat USING (classpat_id)
LEFT JOIN hesin_mainspef USING (mainspef_id)
LEFT JOIN hesin_tretspef USING (tretspef_id);

CREATE VIEW hesin_diag AS
SELECT
eid, ins_index, arr_index, level,
diag_icd9, diag_icd9_nb,
diag_icd10, diag_icd10_nb
FROM hesin_diag_data
LEFT JOIN eids USING(id)
LEFT JOIN hesin_diag_icd9 USING(diag_icd9_id)
LEFT JOIN hesin_diag_icd10 USING(diag_icd10_id);

CREATE VIEW hesin_oper AS
SELECT
 eid, ins_index, arr_index, level,
 opdate, oper3, oper3_nb, oper4, oper4_nb,
 posopdur, preopdur
FROM
hesin_oper_data
LEFT JOIN eids           USING (id)         
LEFT JOIN hesin_oper3  USING (oper3_id) 
LEFT JOIN hesin_oper4  USING (oper4_id);

CREATE VIEW hesin_psych AS
SELECT
 eid, ins_index, detncat, detndate,
 mentcat, admistat, leglstat
FROM
hesin_psych_data
LEFT JOIN eids USING(ID);

CREATE VIEW hesin_maternity AS
SELECT
 eid, ins_index, numbaby, numpreg,
 anasdate, anagest, antedur,
 delinten, delchang, delprean, delposan, delonset,
 postdur, matage
FROM
hesin_maternity_data
LEFT JOIN eids USING(id);

CREATE VIEW hesin_delivery AS
SELECT
eid,
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
FROM hesin_delivery_data
LEFT JOIN eids USING(id);