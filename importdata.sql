-- import

-- set mode to tab seperated
.mode tabs

-- pipe the files through tail to remove the header column
.import '| tail -n +2 gp_registrations.txt' gp_registrations

.import '| tail -n +2 gp_clinical.txt' gp_clinical

.import '| tail -n +2 gp_scripts.txt' gp_scripts

