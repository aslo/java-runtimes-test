#!/bin/sh
#
# Tests cloud debugger integration

project_root=`dirname $0`/..
fixtures_dir=$project_root/fixtures
declare -a test_apps=($fixtures_dir/jar-app $fixtures_dir/servlet-app)

source $project_root/helpers.sh

project=`get_active_project`
project_url_suffix="$(echo $project | tr _ -).appspot.com"
project_version="debugger-test"
deployed_service_url="https://$project_version-dot-$project_url_suffix"

function deploy_and_verify() {
  app_dir=$1

  pushd $app_dir

  # build and deploy
  mvn clean appengine:stage
  sed -i "s/GCP_PROJECT/${project}/g" target/appengine-staging/Dockerfile
  gcloud app deploy target/appengine-staging/app.yaml --version=$project_version --no-promote --quiet

  # TODO clear existing breakpoints

  # set a breakpoint
  # FIXME: do this without needing to know about the app's source structure
  gcloud beta debug snapshots create $app_dir/src/main/java/com/sample/HelloServlet.java:35 --target $project_version

  # exercise the breakpoint
  curl $deployed_service_url

  # verify that the breakpoint has been hit
  # TODO
  #gcloud beta debug snapshots list ...

  popd
}

for app in $test_apps; do
  deploy_and_verify $app
done

