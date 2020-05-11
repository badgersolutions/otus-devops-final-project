.DEFAULT_GOAL := info

info:
	@echo use command: make [start \| stop \| build \| publish \| infra \| deploy]

start:
	cd docker && docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d

stop:
	cd docker && docker-compose down -v

build:
	cd src && mvn -B clean test package

publish:
	cd docker && ./publish-docker-images-to-github-packages.sh

infra:
	@echo deploy infrastructure stub

deploy:
	@echo deploy app to k8s stub
