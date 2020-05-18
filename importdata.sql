-- import

-- set mode to tab seperated
.mode tabs

-- pipe the files through tail to remove the header column
.import '| tail -n +2 gp_registrations.txt' gp_registrations

.import '| tail -n +2 gp_clinical.txt' gp_clinical

.import '| tail -n +2 gp_scripts.txt' gp_scripts

.import '| tail -n +2 hesin.txt' hesin

.import '| tail -n +2 hesin_diag.txt' hesin_diag

.import '| tail -n +2 hesin_oper.txt' hesin_oper

.import '| tail -n +2 hesin_psych.txt' hesin_psych

.import '| tail -n +2 hesin_maternity.txt' hesin_maternity

.import '| tail -n +2 hesin_delivery.txt' hesin_delivery