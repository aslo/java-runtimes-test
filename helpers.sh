#!/bin/sh
#
# Common functions for tests

function push_image() {
    ARTIFACT=$1
    RUNTIME_NAME=$2

    GCP_PROJECT=`gcloud info | sed -rn 's/Project: \[(.*)\]/\1/p' | sed s/-/_/`
    echo Project: $GCP_PROJECT
    DOCKER_NAMESPACE=gcr.io/${GCP_PROJECT}

    CANDIDATE_NAME=`date +%Y-%m-%d_%H_%M`
    echo "CANDIDATE_NAME:${CANDIDATE_NAME}"

    IMAGE_NAME="${DOCKER_NAMESPACE}/${RUNTIME_NAME}:${CANDIDATE_NAME}"
    docker tag "${ARTIFACT}" "${IMAGE_NAME}"
    gcloud docker push "${IMAGE_NAME}"

    if [ "${UPLOAD_TO_STAGING}" = "true" ]; then
      STAGING="${DOCKER_NAMESPACE}/${RUNTIME_NAME}:staging"
      docker tag -f "${ARTIFACT}" "${STAGING}"
      gcloud docker push "${STAGING}"
    fi
}

