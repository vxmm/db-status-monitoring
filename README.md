# db-status-monitoring

Monitoring DB status at an instance/DB level for complete observability: assuming a monitoring solution (e.g. Splunk) is already set up, we attach a script to [master] which reports the status of all DBs and configure Splunk to monitor the output. 

The task is configured to automatically run every 10 minutes via Task Scheduler and the solution is deployed via Ansible. 

# Solution Architecture 

![image](https://github.com/user-attachments/assets/fb11dc16-1831-4016-90da-15d30c315293)

# Deployment

The scripts are deployed from your local folder/jump server (if applicable).

Monitoring will happen in a .txt file under C://logs.txt; if you need this changed, you'll need to alter both the ansible playbook's Splunk monitor as well as the output path incheckDBStatus.sql

Currently, the script only produces an output to check if the DBs are "ONLINE" but you can change this behavior to report any state_desc in sys.database inside checkDBStatus.sql

For manual removal, you will need to delete: 

* script files 

* C://logs.txt 

* stored procedure under [master]

* DB_monitoring task under Task Scheduler

# Troubleshooting

* If the script does not produce an output, you will need to identify the SQLSERVER user specific to your DB and modify the respective Ansible task to give it full control over the file. 

* If there are two instances of SQLSERVER (e.g. SQLServer 2014 and SQLServer 2019) installed on your machine, it appears that only the SQLServer 2014 gets installed.

# Known issues
