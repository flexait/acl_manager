build:
	docker build -t app . --no-cache --build-arg USER=$$(id -un) --build-arg UID=$$(id -u)

up:
	docker-compose up

bash:
	docker-compose run -w /var/www/app app sh -c "stty cols 200 && bash"

migrate:
	docker-compose run app rails db:migrate

bundle:
	docker-compose run app bundle install -j 10
