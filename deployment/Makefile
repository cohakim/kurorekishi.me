.PHONY: recommended_ami
recommended_ami:
  aws ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux/recommended

.PHONY: setup-cluster
setup-cluster:
  ecs-cli up \
    --azs ap-northeast-1d,ap-northeast-1c \
    --capability-iam \
    --keypair default

.PHONY: setup-cluster-kurorekishi
setup-cluster-kurorekishi:
  ecs-cli up \
    --vpc vpc-2fcbc54b \
    --subnets subnet-e6bca4be,subnet-021fb2e335d80e0f0 \
    --security-group sg-6ad3e40c \
    --capability-iam \
    --keypair default \
    --force

