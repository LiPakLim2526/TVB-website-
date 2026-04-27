docker-compose up -d --build

docker exec -i mysql_db mysql -uroot -prootroot tvb_charity_db < my_backup.sql

docker-compose up -d --build

docker-compose down
docker-compose up -d

docker ps

docker-compose logs mysql_db

docker-compose exec web1 python -m flask shell

>>> from app import db
>>> db.create_all() 
>>> exit()
