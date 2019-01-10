#!/bin/sh

echo "Waiting for postgres..."

while ! nc -z users-db 5432; do
  sleep 0.1
done

echo "PostgreSQL started"

<<<<<<< HEAD
<<<<<<< HEAD
python manage.py recreate_db
python manage.py seed_db
=======
python manage.py recreate-db
python manage.py seed-db
>>>>>>> hopefully fixed some problems with cypress
=======
python manage.py recreate-db
python manage.py seed-db
>>>>>>> 8df374ef03d3617c32cba3875547f2176db60b0e
gunicorn -b 0.0.0.0:5000 manage:app
