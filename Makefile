.DEFAULT_GOAL := info

info:
	@echo use command: make [build \| publish \| infra \| deploy]

build:
	cd src && mvn -B clean test package

publish:
	cd docker && ./publish-docker-images-to-github-packages.sh

infra:
	@echo deploy infrastructure stub

deploy:
	@echo deploy app to k8s stub
