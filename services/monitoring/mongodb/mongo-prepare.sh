[ -d /etc/zabbix/scripts ] || mkdir /etc/zabbix/scripts/
chown root:zabbix -R /etc/zabbix/scripts/
chmod 750 /etc/zabbix/scripts/
 
[ -f /etc/zabbix/scripts/mongodb.sh ] || touch /etc/zabbix/scripts/mongodb.sh
chown root:zabbix /etc/zabbix/scripts/mongodb.sh
chmod 550 /etc/zabbix/scripts/mongodb.sh

