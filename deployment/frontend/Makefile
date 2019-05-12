ROOT_PATH  := $(ROOT_PATH)
NAME       := frontend

.PHONY: deploy
deploy:
	ecs-cli compose                                               \
		--project-name $(NAME)                                      \
		--file $(ROOT_PATH)/deployment/$(NAME)/docker-compose.yml   \
		--ecs-params $(ROOT_PATH)/deployment/$(NAME)/ecs-params.yml \
		up                                                          \
		--launch-type EC2                                           \
		--create-log-groups
