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
	aws cloudformation create-stack --stack-name vpc --template-body file://cf-public-private-vpc.yml --parameters ParameterKey=EnvironmentName,ParameterValue=production --on-failure DO_NOTHING

delete-vpc:
	aws cloudformation delete-stack --stack-name vpc

create-ecscluster:
	aws cloudformation create-stack --stack-name ecs-cluster --template-body file://cf-ecs-cluster.yml --parameters ParameterKey=EnvironmentName,ParameterValue=production --on-failure DO_NOTHING --capabilities CAPABILITY_IAM

delete-ecscluster:
	aws cloudformation delete-stack --stack-name ecs-cluster

create-alb-public:
	aws cloudformation create-stack --stack-name alb-public --template-body file://cf-alb-external.yml --parameters ParameterKey=EnvironmentName,ParameterValue=production --on-failure DO_NOTHING

delete-alb-public:
	aws cloudformation delete-stack --stack-name alb-public

create-alb-private:
	aws cloudformation create-stack --stack-name alb-private --template-body file://cf-alb-internal.yml --parameters ParameterKey=EnvironmentName,ParameterValue=production --on-failure DO_NOTHING

delete-alb-private:
	aws cloudformation delete-stack --stack-name alb-private

create-api-service:
	aws cloudformation create-stack --stack-name ecs-api --template-body file://service-fargate-api.yml --parameters ParameterKey=EnvironmentName,ParameterValue=production --on-failure DO_NOTHING

delete-api-service:
	aws cloudformation delete-stack --stack-name ecs-api

create-tf-service:
	aws cloudformation create-stack --stack-name ecs-tf --template-body file://service-fargate-tf.yml --parameters ParameterKey=EnvironmentName,ParameterValue=production --on-failure DO_NOTHING

delete-tf-service:
	aws cloudformation delete-stack --stack-name ecs-tf

post-aws-api:
	curl -H 'Content-Type: application/json' -d '{"input": "Dubois - who won 37 bouts as an amateur with three defeats - will make her professional debut against Vaida Masiokaite from Lithuania at the Motorpoint Arena in Cardiff on Saturday"}' -X POST http://alb-p-Publi-16J22JJHGE7I1-1885730180.us-east-2.elb.amazonaws.com/predict

post-aws-api-bad:
	curl -H 'Content-Type: application/json' -d '{"input": }' -X POST http://alb-PublicL-1NFGJVJW2BKS4-904981647.us-east-2.elb.amazonaws.com/predict
