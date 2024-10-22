#! /usr/bin/env bash
set -e

#
# The follow block comes from tiangolo/uvicorn-gunicorn-docker
# MIT License: https://github.com/tiangolo/uvicorn-gunicorn-docker/blob/master/LICENSE
#

if [ -f /app/app/main.py ]; then
    DEFAULT_MODULE_NAME=app.main
elif [ -f /app/main.py ]; then
    DEFAULT_MODULE_NAME=main
fi
MODULE_NAME=${MODULE_NAME:-$DEFAULT_MODULE_NAME}

# If there's a prestart.sh script in the /app directory or other path specified, run it before starting
PRE_START_PATH=${PRE_START_PATH:-/app/prestart.sh}
echo "Checking for script in $PRE_START_PATH"
if [ -f $PRE_START_PATH ]; then
    echo "Running script $PRE_START_PATH"
    . "$PRE_START_PATH"
else
    echo "There is no script $PRE_START_PATH"
fi

#
# End of tiangolo/uvicorn-gunicorn-docker block
#

if [[ $RELOAD == "true" ]]; then
    watchfiles "exec python -m $MODULE_NAME" /app
else
    exec python -m "$MODULE_NAME"
fi
