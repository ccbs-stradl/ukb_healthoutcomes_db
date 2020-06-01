-- import text files tables

-- set mode to tab seperated
.mode tabs

-- pipe the files through tail to remove the header column
.import '| tail -n +2 gp_registrations.txt' gp_registrations_txt

.import '| tail -n +2 gp_clinical.txt' gp_clinical_txt

.import '| tail -n +2 gp_scripts.txt' gp_scripts_txt

.import '| tail -n +2 hesin.txt' hesin_txt

.import '| tail -n +2 hesin_diag.txt' hesin_diag_txt

.import '| tail -n +2 hesin_oper.txt' hesin_oper_txt

.import '| tail -n +2 hesin_psych.txt' hesin_psych_txt

.import '| tail -n +2 hesin_maternity.txt' hesin_maternity_txt

.import '| tail -n +2 hesin_delivery.txt' hesin_delivery_txt