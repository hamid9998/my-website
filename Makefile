# Convenience Makefile for local development and Docker

.PHONY: install run dev build up down logs clean docker-build

install:
	npm install

run:
	npm start

dev:
	npm run dev

# Docker targets
docker-build:
	docker build -t my-website .

build: docker-build

up:
	docker compose up --build

down:
	docker compose down

logs:
	docker compose logs -f

clean:
	rm -rf node_modules
	rm -f package-lock.json
