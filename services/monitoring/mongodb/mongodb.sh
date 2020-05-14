#!/bin/bash

##### Help #####
help () {
  echo "Usage: $0 mongostat_metric"
  echo "For example: $0 net_in"

}

##### OPTIONS VERIFICATION #####
if [[ -z "$1" ]]; then
   help
  exit 1
fi

##### PARAMETERS #####
HOSTNAME=$(hostname -f)
AWK=$(which awk)
GREP=$(which grep)
METRIC="$1"
MONGOSTAT=$(which mongostat)
CACHE_TTL="55"
CACHE_FILE="/tmp/zabbix.mongo.`echo $HOSTNAME | md5sum | cut -d" " -f1`.cache"
EXEC_TIMEOUT="1"
NOW_TIME=`date '+%s'`

DB_USERNAME="piggy"
DB_PASSWORD="piggy"

##### RUN #####
if [ -s "${CACHE_FILE}" ]; then
  CACHE_TIME=`stat -c"%Y" "${CACHE_FILE}"`
else
  CACHE_TIME=0
fi
DELTA_TIME=$((${NOW_TIME} - ${CACHE_TIME}))
#
if [ ${DELTA_TIME} -lt ${EXEC_TIMEOUT} ]; then
 sleep $((${EXEC_TIMEOUT} - ${DELTA_TIME}))
elif [ ${DELTA_TIME} -gt ${CACHE_TTL} ]; then
  echo "" >> "${CACHE_FILE}" # !!!

  if [ -z ${DB_USERNAME} ] ||  [ -z ${DB_PASSWORD} ];
    then
### Access without authentication
   DATACACHE=`${MONGOSTAT} --all --noheaders --humanReadable=false -n 1 | sed 's/^[ \t]*//;s/*//g'  2>&1`
    else
###  Access with authentication
   DATACACHE=`${MONGOSTAT} -u "${DB_USERNAME}" -p "${DB_PASSWORD}" --authenticationDatabase "admin" --all --noheaders  --humanReadable=false -n 1 | sed 's/^[ \t]*//;s/*//g'  2>&1`
   fi


  echo "${DATACACHE}" > "${CACHE_FILE}" # !!!
  chmod 640 "${CACHE_FILE}"
fi

case ${METRIC} in
 ops_insert)
        awk '{print $1}' "${CACHE_FILE}"
        ;;
 ops_query)
        awk '{print $2}' "${CACHE_FILE}"
        ;;
 ops_update)
        awk '{print $3}' "${CACHE_FILE}"
        ;;
 ops_delete)
        awk '{print $4}' "${CACHE_FILE}"
        ;;
 ops_getmore)
        awk '{print $5}' "${CACHE_FILE}"
        ;;
 command_local)
        awk '{print $6}' "${CACHE_FILE}" | awk -F\| '{print $1}'
        ;;
 command_replicated)
        awk '{print $6}' "${CACHE_FILE}" | awk -F\| '{print $2}'
        ;;
 cache_dirty)
        awk '{print $7}' "${CACHE_FILE}"
        ;;
 cache_used)
        awk '{print $8}' "${CACHE_FILE}"
        ;;
 flushes)
        awk '{print $9}' "${CACHE_FILE}"
        ;;
 memory_vsize)
        awk 'x=$10 {print x/1024/1024}' "${CACHE_FILE}"
        ;;
 memory_res)
        awk 'x=$11 {print x/1024/1024}' "${CACHE_FILE}"
        ;;
 queue_read)
         awk '{print $12}' "${CACHE_FILE}" | awk -F\| '{print $1}'
        ;;
 queue_write)
         awk '{print $12}' "${CACHE_FILE}" | awk -F\| '{print $2}'
        ;;
 active_read)
        awk '{print $13}' "${CACHE_FILE}" | awk -F\| '{print $1}'
        ;;
 active_write)
        awk '{print $13}' "${CACHE_FILE}" | awk -F\| '{print $2}'
        ;;
 net_in)
        awk 'x=$14 {print x/1024}' "${CACHE_FILE}"
        ;;
 net_out)
        awk 'x=$15 {print x/1024}' "${CACHE_FILE}"
        ;;
 total_connections)
        awk '{print $16}' "${CACHE_FILE}"
        ;;
 replset)
        awk '{print $17}' "${CACHE_FILE}"
        ;;
 replrole)
        awk '{print $18}' "${CACHE_FILE}"
        ;;
 *)
        help
        ;;
esac

exit 0
