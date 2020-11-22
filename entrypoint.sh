#!/bin/bash
cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo "${MODIFIED_STARTUP}"

# Run the Server
npm install --production --quiet --no-progress --loglevel=error && npm audit fix --quiet --no-progress --loglevel=error
eval ${MODIFIED_STARTUP}
