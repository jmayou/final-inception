up:
	docker compose -f srcs/docker-compose.yml up -d

build:
	docker compose -f srcs/docker-compose.yml build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down

fclean: clean
	@if [ -n "$$(docker ps -aq)" ]; then docker stop $$(docker ps -aq); fi
	@if [ -n "$$(docker ps -aq)" ]; then docker rm $$(docker ps -aq); fi
	@if [ -n "$$(docker images -aq)" ]; then docker rmi $$(docker images -aq); fi
	docker system prune -af
	docker network prune -f
	docker volume prune -f
	sudo rm -rf /home/jmayou/data/*

re: down up 

sre: fclean build up
