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
