#!/bin/bash

service ntp start

if ! [ -z ${GIT_PATH} ]
then
  cd /code
  git config --global pull.ff only && \
  git config --global init.defaultBranch master && \
  git init && \
  git remote add master http://${GIT_USERNAME}:${GIT_PASSWORD}@${GIT_PATH}
  git pull master master
fi
chmod -R 777 /code 

if [ -d /code/scripts_init ];
then
  for f in /code/scripts_init/*; 
    do $f; 
  done
fi

if ! [ -z ${MAIL_SERVER} ]
then
  envsubst < /code/muttrc.template > ~/.mutt/muttrc
fi

cron -f