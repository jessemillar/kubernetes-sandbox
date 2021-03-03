SHELL := /bin/bash

all: create-cluster build apply

create-cluster:
	kind create cluster || true

delete-cluster:
	kind delete cluster || true

build:
	docker build -t jessemillar/sandbox:latest .
	docker push jessemillar/sandbox:latest

apply:
	kubectl delete -f configmap.yaml || true
	kubectl delete -f role.yaml || true
	kubectl delete -f rolebinding.yaml || true
	kubectl delete -f manifest.yaml || true
	kubectl apply -f configmap.yaml
	kubectl apply -f role.yaml
	kubectl apply -f rolebinding.yaml
	kubectl apply -f manifest.yaml
