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
	date(substr(epistart, 1, 4) || '-' ||
	     substr(epistart, 5, 2) || '-' ||
	     substr(epistart, 7, 2)) AS epistart,
	date(substr(epiend, 1, 4) || '-' ||
		   substr(epiend, 5, 2) || '-' ||
		   substr(epiend, 7, 2)) AS epiend,
epidur, bedyear, epistat, epitype, epiorder,
spell_index, spell_seq, spelbgin, spelend, speldur,
pctcode, gpprpct, category,
	date(substr(elecdate, 1, 4) || '-' ||
	     substr(elecdate, 5, 2) || '-' ||
	     substr(elecdate, 7, 2)) AS elecdate,
	elecdur,
	date(substr(admidate, 1, 4) || '-' ||
       substr(admidate, 5, 2) || '-' ||
       substr(admidate, 7, 2)) AS admidate,
admimeth_uni, admimeth, admisorc_uni, admisorc,
firstreg, classpat_uni, classpat, intmanag_uni, intmanag,
mainspef_uni, mainspef, tretspef_uni, tretspef, operstat,
	date(substr(disdate, 1, 4) || '-' ||
		   substr(disdate, 5, 2) || '-' ||
		   substr(disdate, 7, 2)) AS disdate,
dismeth_uni, dismeth, disdest_uni, disdest, carersi
FROM
hesin_txt;

CREATE VIEW hesin_diag AS
SELECT *
FROM
hesin_diag_txt;

CREATE VIEW hesin_oper AS
SELECT
 eid, ins_index, arr_index, level,
 date(substr(opdate, 7, 4) || '-' ||
 	    substr(opdate, 4, 2) || '-' ||
	    substr(opdate, 1, 2)) AS opdate,
oper3	TEXT, oper3_nb, oper4	TEXT, oper4_nb, posopdur, preopdur
FROM
hesin_oper_txt;

CREATE VIEW hesin_psych AS
SELECT
 eid, ins_index, detncat,
 date(substr(detndate, 7, 4) || '-' ||
 	    substr(detndate, 4, 2) || '-' ||
	    substr(detndate, 1, 2)) AS detndate,
 mentcat, admistat, leglstat
FROM
hesin_psych_txt;

CREATE VIEW hesin_maternity AS
SELECT
 eid, ins_index, numbaby, numpreg,
 date(substr(anasdate, 7, 4) || '-' ||
 	    substr(anasdate, 4, 2) || '-' ||
	    substr(anasdate, 1, 2)) AS anasdate,
anagest, antedur, delinten, delchang, delprean, delposan, delonset, postdur, matage
FROM
hesin_maternity_txt;

CREATE VIEW hesin_delivery AS
SELECT *
FROM
hesin_delivery_txt;