#!/bin/bash
if [ -f "/code/cron.list" ];
then  
  crontab /code/cron.list;
fi
