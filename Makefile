init: docker-down-clear docker-pull docker-build docker-up
up: docker-up
down: docker-down

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build

docker-password:
	docker run --rm registry:2.6 htpasswd -Bbn dockerhub dockerhub > htpasswd

deploy:
	ssh deploy@${HOST} -p ${PORT} 'rm -rf dockerhub && mkdir dockerhub'
	scp -P ${PORT} docker-compose-production.yml deploy@${HOST}:dockerhub/docker-compose.yml
	scp -P ${PORT} -r docker deploy@${HOST}:dockerhub/docker
	scp -P ${PORT} htpasswd deploy@${HOST}:dockerhub/htpasswd
	ssh deploy@${HOST} -p ${PORT} 'cd dockerhub && echo "COMPOSE_PROJECT_NAME=dockerhub" >> .env'
	ssh deploy@${HOST} -p ${PORT} 'cd dockerhub && docker-compose down --remove-orphans'
	ssh deploy@${HOST} -p ${PORT} 'cd dockerhub && docker-compose pull'
	ssh deploy@${HOST} -p ${PORT} 'cd dockerhub && docker-compose up -d'
