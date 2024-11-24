all: 
	@echo "Building and starting containers..."
	docker compose -f srcs/docker-compose.yml up --build -d
	
down: 
	@echo "Stopping and cleaning containers..."
	docker compose -f srcs/docker-compose.yml down -v
	docker system prune -af
	rm -rf /home/ibenzian/data/mariadb/*
	rm -rf /home/ibenzian/data/wordpress/*


re: down all

