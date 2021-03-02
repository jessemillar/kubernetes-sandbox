SHELL := /bin/bash

all: build apply

build:
	docker build -t jessemillar/sandbox:latest .
	docker push jessemillar/sandbox:latest

apply:
	kubectl delete -f manifest.yaml || true
	kubectl apply -f manifest.yaml
