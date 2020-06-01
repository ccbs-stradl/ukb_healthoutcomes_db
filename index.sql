-- add indices to the database

CREATE INDEX idx_gp_registrations_txt_eid
ON gp_registrations_txt (eid);

CREATE INDEX idx_gp_registrations_txt_reg_date
ON gp_registrations_txt (reg_date);

CREATE INDEX idx_gp_clinical_txt_eid_event_dt
ON gp_clinical_txt (eid, event_dt);

CREATE INDEX idx_gp_clinical_txt_event_dt
ON gp_clinical_txt (event_dt);

CREATE INDEX idx_gp_clinical_txt_read_2
ON gp_clinical_txt (read_2);

CREATE INDEX idx_gp_clinical_txt_read_3
ON gp_clinical_txt (read_3);

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