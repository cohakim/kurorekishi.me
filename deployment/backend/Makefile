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
		--create-log-groups                                         \
		--role ecsServiceRole                                       \
		--container-name backend

.PHONY: awslogs
awslogs:
	awslogs get -G -S -w --timestamp -s 30m clean_them_all backend
