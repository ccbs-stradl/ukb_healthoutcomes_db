-- add indices to the database

-- IDs
CREATE INDEX idx_eids_eid
ON eids (eid);


-- GP Registrations


CREATE INDEX idx_gp_registrations_data_reg_date
ON gp_registrations_data (reg_date);

-- GP Clinical
CREATE INDEX idx_gp_clinical_data_id_event_dt
ON gp_clinical_data (id, event_dt);

CREATE INDEX idx_gp_clinical_data_event_dt
ON gp_clinical_data (event_dt);

CREATE INDEX idx_gp_clinical_data_read_2
ON gp_clinical_data (read_2_id);

CREATE INDEX idx_gp_clinical_read_2
ON gp_clinical_read_2 (read_2);

CREATE INDEX idx_gp_clinical_read_3
ON gp_clinical_read_3 (read_3);

CREATE INDEX idx_gp_clinical_data_read_3
ON gp_clinical_data (read_3_id);

-- GP Scripts
CREATE INDEX idx_gp_scripts_data_id_issue_date
ON gp_scripts_data (id, issue_date);

CREATE INDEX idx_gp_scripts_data_issue_date
ON gp_scripts_data (issue_date);

CREATE INDEX idx_gp_scripts_data_codes
ON gp_scripts_data (codes_id);

CREATE INDEX idx_gp_scripts_codes_read_2
ON gp_scripts_codes (read_2_id);

CREATE INDEX idx_gp_scripts_read_2
ON gp_scripts_read_2 (read_2);

CREATE INDEX idx_gp_scripts_codes_bnf_code
ON gp_scripts_codes (bnf_code_id);

CREATE INDEX idx_gp_scripts_bnf_code
ON gp_scripts_bnf_code (bnf_code);

CREATE INDEX idx_gp_scripts_codes_dmd_code
ON gp_scripts_codes (dmd_code_id);

CREATE INDEX idx_gp_scripts_dmd_code
ON gp_scripts_dmd_code (dmd_code);

CREATE INDEX idx_gp_scripts_codes_drug_name
ON gp_scripts_codes (drug_name_id);

CREATE INDEX idx_gp_scripts_drug_name
ON gp_scripts_drug_name (drug_name);

-- HESIN

CREATE INDEX idx_hesin_data_id_ins_index
ON hesin_data (id, ins_index);

CREATE INDEX idx_hesin_data_epistart_epiend
ON hesin_data (epistart, epiend);

CREATE INDEX idx_hesin_data_mainspef_uni
ON hesin_data (mainspef_uni);

-- HESIN Diagnoses

CREATE INDEX idx_hesin_diag_data_id_ins_index_arr_index
ON hesin_diag_data (id, ins_index, arr_index);

CREATE INDEX idx_hesin_diag_icd9
ON hesin_diag_icd9 (diag_icd9);

CREATE INDEX idx_hesin_diag_data_icd9
ON hesin_diag_data (diag_icd9_id);

CREATE INDEX idx_hesin_diag_icd10
ON hesin_diag_icd10 (diag_icd10);

CREATE INDEX idx_hesin_diag_data_icd10
ON hesin_diag_data (diag_icd10_id);

-- HESIN Operations

CREATE INDEX idx_hesin_oper_data_id_ins_index_arr_index
ON hesin_oper_data (id, ins_index, arr_index);

CREATE INDEX idx_hesin_oper_data_opdate
ON hesin_oper_data (opdate);

CREATE INDEX idx_hesin_oper3
ON hesin_oper3 (oper3);

CREATE INDEX idx_hesin_data_oper3
ON hesin_oper_data (oper3_id);

CREATE INDEX idx_hesin_oper4
ON hesin_oper4 (oper4);

CREATE INDEX idx_hesin_data_oper4
ON hesin_oper_data (oper4_id);

-- HESIN Psychiatry

CREATE INDEX idx_hesin_psych_data_id_ins_index
ON hesin_psych_data (id, ins_index);

CREATE INDEX idx_hesin_psych_data_mentcat
ON hesin_psych_data (mentcat);

-- HESIN Maternity

CREATE INDEX idx_hesin_maternity_data_id_ins_index
ON hesin_maternity_data (id, ins_index);

-- HESIN Delivery

CREATE INDEX idx_hesin_delivery_data_id_ins_index_arr_index
ON hesin_delivery_data (id, ins_index, arr_index);


