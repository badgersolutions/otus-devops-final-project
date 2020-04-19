#!/bin/bash
set -e

# https://github.com/settings/tokens

export USER_LOGIN=bard86

cat ~/GH_TOKEN | docker login docker.pkg.github.com -u $USER_LOGIN --password-stdin

export WORKDIR=`pwd`

for service in account-service auth-service config gateway monitoring notification-service registry statistics-service turbine-stream-service
do
  cd $WORKDIR/../src/$service
  docker build -t docker.pkg.github.com/badgersolutions/otus-devops-final-project/piggymetrics_$service:latest .
  docker push docker.pkg.github.com/badgersolutions/otus-devops-final-project/piggymetrics_$service:latest
done

cd $WORKDIR/../service/mongodb
docker build -t docker.pkg.github.com/badgersolutions/otus-devops-final-project/piggymetrics_mongodb:latest .
docker push docker.pkg.github.com/badgersolutions/otus-devops-final-project/piggymetrics_mongodb:latest
