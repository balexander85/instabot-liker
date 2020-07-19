#!/usr/bin/env bash

# Start the run once job.
echo "Docker container has been started"

# Setup a cron schedule
echo "0 */4 * * * /usr/local/bin/python /code/docker_quickstart.py >> /var/log/cron.log 2>&1
# This extra line makes it a valid cron" > scheduler.txt

crontab scheduler.txt
cron -f



