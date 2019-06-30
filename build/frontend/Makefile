ROOT_PATH  := $(ROOT_PATH)
PROJECT    := clean_them_all
NAME       := frontend
VERSION    := latest
REPOSITORY := 081239106582.dkr.ecr.ap-northeast-1.amazonaws.com

.PHONY: build
build:
	docker build -f $(ROOT_PATH)/build/$(NAME)/Dockerfile -t $(PROJECT)/$(NAME):$(VERSION) $(ROOT_PATH) --squash

.PHONY: prepare
prepare:
	$$(aws ecr get-login --no-include-email)
	aws ecr create-repository --repository-name $(PROJECT)/$(NAME)

.PHONY: push
push:
	$$(aws ecr get-login --no-include-email)
	docker tag $(PROJECT)/$(NAME):$(VERSION) $(REPOSITORY)/$(PROJECT)/$(NAME):$(VERSION)
	docker push $(REPOSITORY)/$(PROJECT)/$(NAME):$(VERSION)

.PHONY: up
up:
	@docker-compose -f $(ROOT_PATH)/build/docker-compose.yml up $(NAME)

.PHONY: down
down:
	docker-compose -f $(ROOT_PATH)/build/docker-compose.yml down
