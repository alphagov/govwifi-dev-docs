build: stop
	docker-compose build

serve: build
	docker-compose run --service-ports app bundle exec middleman server --watcher-force-polling

stop:
	docker-compose kill
	docker-compose rm -f

.PHONY: build deploy stop
