-- import text files tables

-- set mode to tab seperated
.mode tabs

-- pipe the files through tail to remove the header column
.import '| tail -n +2 gp_registrations.txt' gp_registrations_txt

-- add extra record IDs based on row number since entries are not unique
.import "| tail -n +2 gp_clinical.txt | awk -v OFS='\t' '{print NR, $0}'" gp_clinical_txt

-- add extra record IDs based on row number since entries are not unique
.import "| tail -n +2 gp_scripts.txt | awk -v OFS='\t' '{print NR, $0}'" gp_scripts_txt

.import '| tail -n +2 hesin.txt' hesin_txt

.import '| tail -n +2 hesin_diag.txt' hesin_diag_txt

.import '| tail -n +2 hesin_oper.txt' hesin_oper_txt

.import '| tail -n +2 hesin_psych.txt' hesin_psych_txt

.import '| tail -n +2 hesin_maternity.txt' hesin_maternity_txt

.import '| tail -n +2 hesin_delivery.txt' hesin_delivery_txt

--
-- EIDs
--

-- collect all EIDs together 
INSERT INTO eids
  SELECT DISTINCT NULL, eid
    FROM(SELECT eid FROM gp_registrations_txt
         UNION
         SELECT eid FROM gp_clinical_txt
         UNION
         SELECT eid FROM gp_scripts_txt
         UNION
         SELECT eid FROM hesin_txt
         UNION
         SELECT eid FROM hesin_delivery_txt
         UNION
         SELECT eid FROM hesin_diag_txt
         UNION
         SELECT eid FROM hesin_maternity_txt
         UNION
         SELECT eid FROM hesin_oper_txt
         UNION
         SELECT eid FROM hesin_psych_txt     
       );