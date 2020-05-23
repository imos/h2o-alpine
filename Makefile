build:
	docker build -t imos/h2o .
	docker tag imos/h2o imos/h2o:2
	docker tag imos/h2o imos/h2o:2.2
	docker tag imos/h2o imos/h2o:2.2.6
.PHONY: build

push:
	docker push imos/h2o
	docker push imos/h2o:2
	docker push imos/h2o:2.2
	docker push imos/h2o:2.2.6
.PHONY: push
