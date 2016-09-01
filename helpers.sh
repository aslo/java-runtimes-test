#!/bin/sh
#
# Common functions for tests

function get_active_project() {
  echo `gcloud info | sed -rn 's/Project: \[(.*)\]/\1/p' | sed s/-/_/`
}

function push_image() {
  ARTIFACT=$1
  RUNTIME_NAME=$2

  GCP_PROJECT=`get_active_project`
  echo Project: $GCP_PROJECT
  DOCKER_NAMESPACE=gcr.io/${GCP_PROJECT}

  CANDIDATE_NAME=`date +%Y-%m-%d_%H_%M`
  echo "CANDIDATE_NAME:${CANDIDATE_NAME}"

  IMAGE_NAME="${DOCKER_NAMESPACE}/${RUNTIME_NAME}:${CANDIDATE_NAME}"
  docker tag "${ARTIFACT}" "${IMAGE_NAME}"
  echo "Pushing $IMAGE_NAME"
  gcloud docker push "${IMAGE_NAME}"

  TESTING="${DOCKER_NAMESPACE}/${RUNTIME_NAME}:testing"
  docker tag -f "${ARTIFACT}" "${TESTING}"
  echo "Pushing $TESTING"
  gcloud docker push "${TESTING}"
}

function deploy() {
  runtime=$1
  app_dir=$2
  project_version=$3

  pushd $app_dir

  # build and stage
  mvn clean appengine:stage -P $runtime
  sed -i "s/GCP_PROJECT/`get_active_project`/g" target/appengine-staging/Dockerfile

  # deploy
  gcloud app deploy target/appengine-staging/app.yaml --version=$project_version --no-promote --quiet

  popd
}
