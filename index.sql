-- add indices to the database


-- GP Registrations
CREATE INDEX idx_gp_registrations_txt_eid
ON gp_registrations_txt (eid);

CREATE INDEX idx_gp_registrations_txt_reg_date
ON gp_registrations_txt (reg_date);

-- GP Clinical
CREATE INDEX idx_gp_clinical_txt_eid_event_dt
ON gp_clinical_txt (eid, event_dt);

CREATE INDEX idx_gp_clinical_txt_event_dt
ON gp_clinical_txt (event_dt);

CREATE INDEX idx_gp_clinical_txt_read_2
ON gp_clinical_txt (read_2);

CREATE INDEX idx_gp_clinical_txt_read_3
ON gp_clinical_txt (read_3);

-- GP Scripts
CREATE INDEX idx_gp_scripts_txt_eid_issue_date
ON gp_scripts_txt (eid, issue_date);

CREATE INDEX idx_gp_scripts_txt_issue_date
ON gp_scripts_txt (issue_date);

CREATE INDEX idx_gp_scripts_txt_read_2
ON gp_scripts_txt (read_2);

CREATE INDEX idx_gp_scripts_txt_bnf_code
ON gp_scripts_txt (bnf_code);

CREATE INDEX idx_gp_scripts_txt_dmd_code
ON gp_scripts_txt (dmd_code);

CREATE INDEX idx_gp_scripts_txt_drug_name
ON gp_scripts_txt (drug_name);

-- HESIN

CREATE INDEX idx_hesin_txt_eid_ins_index
ON hesin_txt (eid, ins_index);

CREATE INDEX idx_hesin_txt_epistart_epiend
ON hesin_txt (epistart, epiend);

CREATE INDEX idx_hesin_txt_mainspef_uni
ON hesin_txt (mainspef_uni);

-- HESIN Diagnoses

CREATE INDEX idx_hesin_diag_txt_eid_ins_index_arr_index
ON hesin_diag_txt (eid, ins_index, arr_index);

CREATE INDEX idx_hesin_diag_txt_diag_icd9
ON hesin_diag_txt (diag_icd9);

CREATE INDEX idx_hesin_diag_txt_diag_icd10
ON hesin_diag_txt (diag_icd10);

-- HESIN Operations

CREATE INDEX idx_hesin_oper_txt_eid_ins_index_arr_index
ON hesin_oper_txt (eid, ins_index, arr_index);

CREATE INDEX idx_hesin_oper_txt_opdate
ON hesin_oper_txt (opdate);

CREATE INDEX idx_hesin_oper_txt_oper3
ON hesin_oper_txt (oper3);

CREATE INDEX idx_hesin_oper_txt_oper4
ON hesin_oper_txt (oper4);

-- HESIN Psychiatry

CREATE INDEX idx_hesin_psych_txt_eid_ins_index
ON hesin_psych_txt (eid, ins_index);

CREATE INDEX idx_hesin_psych_txt_mentcat
ON hesin_psych_txt (mentcat);

-- HESIN Maternity

CREATE INDEX idx_hesin_maternity_txt_eid_ins_index
ON hesin_maternity_txt (eid, ins_index);

-- HESIN Delivery

CREATE INDEX idx_hesin_delivery_txt_eid_ins_index_arr_index
ON hesin_delivery_txt (eid, ins_index, arr_index);

-- get statistics for the query planner
ANALYZE;
