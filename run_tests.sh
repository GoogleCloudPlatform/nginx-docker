#!/bin/bash
RANDOM_NAME=$RANDOM
IMAGE="launcher.gcr.io/google/nginx1:latest"

docker run --rm -it \
    -v $PWD/tests/functional_tests:/functional_tests:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    gcr.io/cloud-marketplace-ops-test/functional_test \
    --verbose \
    --vars UNIQUE=$RANDOM_NAME \
    --vars IMAGE=$IMAGE \
    --test_spec /functional_tests/running_test.yaml


IMAGE="launcher.gcr.io/google/nginx1:latest"
docker run --rm -it \
    -v $PWD/tests/functional_tests:/functional_tests:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    gcr.io/cloud-marketplace-ops-test/functional_test \
    --verbose \
    --vars UNIQUE=$RANDOM_NAME \
    --vars IMAGE=$IMAGE \
    --test_spec /functional_tests/prometheus_exporter_test.yaml


IMAGE="gcr.io/orbitera-dev/nginx-prometheus-exporter0"
docker run --rm -it \
    -v $PWD/tests/functional_tests:/functional_tests:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    gcr.io/cloud-marketplace-ops-test/functional_test \
    --verbose \
    --vars UNIQUE=$RANDOM_NAME \
    --vars IMAGE=$IMAGE \
    --test_spec /functional_tests/prometheus_nginx_test.yaml