ROOT_PATH  := $(ROOT_PATH)
CLUSTER    := kurorekishi-me
NAME       := backend

.PHONY: deploy
deploy:
	ecs-cli compose                                               \
		--cluster $(CLUSTER)                                        \
		--project-name $(NAME)                                      \
		--file $(ROOT_PATH)/deployment/$(NAME)/docker-compose.yml   \
		--ecs-params $(ROOT_PATH)/deployment/$(NAME)/ecs-params.yml \
		service up                                                  \
		--launch-type EC2                                           \
		--create-log-groups
