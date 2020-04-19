## Application and infrastructure chagelog:

<hr>

## Microservices

 - add gateway
 - add config
 - add auth
 - add account
 - add notification
 - add registry
 - add monitoring
 - add statistics
 - add turbine-stream

## Infrastructure

 - Add 17 VMs for project needs, described [here](https://docs.google.com/spreadsheets/d/1q5eKFaozRY2g78jg781TZ03Olt3Pl4P-oNUH9av66yU/edit?usp=sharing) (read-only)
 - monitoring vm has temporary external IP
 - root login temporary permitted
 - created subnetwork 10.0.1.0/26 called "piggy-subnetwork" in europe-wes1 region in virtual network "piggy-network"
 - created firewall rules to allow all connections inside the piggy subnetwork
 - created firewall rule to allow ssh to all hosts from all hosts (nedd to change later the variable *firewall_ssh_source_ranges*)
<hr>

