.DEFAULT_GOAL := local-run

BACKEND_BINARY_NAME := backend
FRONTEND_BINARY_NAME := frontend

ENVIRONMENT := development

.PHONY: lint-backend
lint-backend:
	cd backend/ && golangci-lint run -v --allow-parallel-runners

.PHONY: lint-frontend
lint-frontend:
	cd frontend/ && bun run lint

.PHONY: lint
lint: lint-backend lint-frontend

.PHONY: clean-backend
clean-backend:
	cd backend/ && go clean

.PHONY: clean-frontend
clean-frontend:
	rm -rf frontend/.next

.PHONY: clean
clean: clean-backend clean-frontend

.PHONY: tidy
tidy:
	cd backend/ && go mod tidy

.PHONY: test
test:
	cd backend/ && go test -covermode=atomic -v -race ./...

.PHONY: build-backend
build-backend:
	cd backend/ && go build -o ${BACKEND_BINARY_NAME} main.go

.PHONY: build-frontend
build-frontend:
	cd frontend/ && bun --bun run build

.PHONY: build
build: build-backend build-frontend

.PHONY: build-backend-docker-image
build-backend-docker-image:
	docker build --platform=linux/amd64 -t $(BACKEND_BINARY_NAME):latest backend/

.PHONY: build-frontend-docker-image
build-frontend-docker-image:
	docker build --platform=linux/amd64 --build-arg ENVIRONMENT=$(ENVIRONMENT) -t $(FRONTEND_BINARY_NAME):latest frontend/

.PHONY: build-docker-images
build-docker-images: build-backend-docker-image build-frontend-docker-image

.PHONY: local-run
local-run: build-docker-images
	docker-compose up --force-recreate --remove-orphans
