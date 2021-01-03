CLUSTER := kurorekishi-me

.PHONY: recommended-ami
recommended-ami:
	aws ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux-2/recommended

.PHONY: setup-cluster
setup-cluster:
	ecs-cli up \
	--cluster $(CLUSTER) \
	--launch-type EC2 \
	--instance-type m3.medium \
	--size 6 \
	--spot-price 0.02 \
	--image-id ami-0b60185623255ce57 \
	--vpc vpc-0ffee845844d25585 \
	--subnets subnet-04b4ab206d6625e78,subnet-07588361410320e9c \
	--security-group sg-031154da5470d733d,sg-04744e60ee6bfb139,sg-01a86733823a315a2 \
	--instance-role ecsInstanceRole
