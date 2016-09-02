#!/bin/sh
#
# Common functions for tests

function get_active_project() {
  echo `gcloud info | sed -rn 's/Project: \[(.*)\]/\1/p'`
}

function push_image() {
  artifact=$1
  runtime_name=$2

  gcp_project=`get_active_project`
  echo Project: $gcp_project
  docker_namespace=gcr.io/${gcp_project}

  candidate_name=`date +%Y-%m-%d_%H_%M`
  echo "CANDIDATE_NAME:${candidate_name}"

  image_name="${docker_namespace}/${runtime_name}:${candidate_name}"
  docker tag "${artifact}" "${image_name}"
  echo "Pushing $image_name"
  gcloud docker push "${image_name}"

  testing="${docker_namespace}/${runtime_name}:testing"
  docker tag -f "${artifact}" "${testing}"
  echo "Pushing $testing"
  gcloud docker push "${testing}"
}

function deploy() {
  runtime=$1
  app_dir=$2
  project_version=$3

  pushd $app_dir

  # build, stage, and deploy
  mvn clean appengine:deploy -P $runtime \
  -Dapp.deploy.project=`get_active_project` \
  -Dapp.deploy.version=$project_version \
  -Dapp.deploy.promote=false \


  popd
}
