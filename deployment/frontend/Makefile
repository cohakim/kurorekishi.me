ROOT_PATH  := $(ROOT_PATH)
CLUSTER    := kurorekishi-me
NAME       := frontend

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
		--container-name frontend                                   \
		--container-port 3000                                       \
		--target-group-arn arn:aws:elasticloadbalancing:ap-northeast-1:081239106582:targetgroup/kurorekishi-me/afa124c1485d41b0

.PHONY: awslogs
awslogs:
	awslogs get -G -S -w --timestamp -s 30s clean_them_all frontend
