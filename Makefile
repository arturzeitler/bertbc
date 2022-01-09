up-local:
	docker-compose -f docker-compose.yml up -d --build

up-prod:
	docker-compose -f docker-compose.prod.yml up -d --build

get-local:
	curl -v http://localhost:8501/v1/models/bertbc:predict

get-local-api:
	curl -v http://localhost:5001

post-local-api:
	curl -H 'Content-Type: application/json' -d '{"input": "Germany have beaten England again in football by 3-0"}' -X POST http://localhost:5001/predict

post-local:
	curl -d '{"inputs":{"input":["Germany have beaten England again in football by 3-0"]}}' -X POST http://localhost:8501/v1/models/bertbc:predict

tests:
	docker-compose run --rm --no-deps --entrypoint=pytest api /tests/

create-vpc:
	aws cloudformation create-stack --stack-name vpc-public --template-body file://cf-public-vpc.yml --parameters ParameterKey=EnvironmentName,ParameterValue=dev --on-failure DO_NOTHING

delete-vpc:
	aws cloudformation delete-stack --stack-name vpc-public

create-ecscluster:
	aws cloudformation create-stack --stack-name ecs-cluster --template-body file://cf-ecs-cluster.yml --parameters ParameterKey=EnvironmentName,ParameterValue=dev --on-failure DO_NOTHING --capabilities CAPABILITY_IAM

delete-ecscluster:
	aws cloudformation delete-stack --stack-name ecs-cluster

create-alb:
	aws cloudformation create-stack --stack-name alb --template-body file://cf-alb-external.yml --parameters ParameterKey=EnvironmentName,ParameterValue=dev --on-failure DO_NOTHING

delete-alb:
	aws cloudformation delete-stack --stack-name alb

create-api-service:
	aws cloudformation create-stack --stack-name ecs-api --template-body file://service-fargate-api.yml --parameters ParameterKey=EnvironmentName,ParameterValue=dev --on-failure DO_NOTHING

delete-api-service:
	aws cloudformation delete-stack --stack-name ecs-api

create-tf-service:
	aws cloudformation create-stack --stack-name ecs-tf --template-body file://service-fargate-tf.yml --parameters ParameterKey=EnvironmentName,ParameterValue=dev --on-failure DO_NOTHING

delete-tf-service:
	aws cloudformation delete-stack --stack-name ecs-tf

post-local-api:
	curl -H 'Content-Type: application/json' -d '{"input": "Germany have beaten England again in football by 3-0"}' -X POST http://alb-PublicL-8TYAB84W1DGJ-145043485.us-east-2.elb.amazonaws.com/predict

post-local-api-bad:
	curl -H 'Content-Type: application/json' -d '{"input": }' -X POST http://alb-PublicL-8TYAB84W1DGJ-145043485.us-east-2.elb.amazonaws.com/predict
