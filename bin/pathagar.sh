#!/bin/sh

set -e

python $SNAP/app/manage.py migrate --noinput
python $SNAP/app/manage.py runserver 0.0.0.0:8000
