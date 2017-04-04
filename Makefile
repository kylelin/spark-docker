.PHONY:
	help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

up:	## docker-compose up to background
	docker-compose up -d

logs:	## docker-compose tail container logs
	docker-compose logs -f

ps:	## docker container list
	docker ps -a

down:	## docker-compose down
	docker-compose down

client:	## docker attach with client where you can play with hdfs and spark
	docker-compose exec client bash

scale:	## make scale type=datanode size=3 or make scale type=sparkslave size=3
	docker-compose scale $(type)=$(size)
