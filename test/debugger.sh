#!/bin/sh
#
# Tests cloud debugger integration

dir=`dirname $0`
declare -a test_apps=($dir/fixtures/jar-app $dir/fixtures/servlet-app)

# HACK: it would be nice if mvn gcloud could just do this
gcloud_directory=`which gcloud | sed 's/\(.*\)\/bin\/.*/\1/'`

# TODO grep from gcloud output to avoid hard coding these?
project_version="debugger-test"
project_url_suffix="tmp-test-project-1380.appspot.com"
deployed_service_url="https://$project_version-dot-$project_url_suffix"

function deploy_and_verify() {
  app_dir=$1

  pushd $app_dir

  # build and deploy
  mvn clean gcloud:deploy -Dgcloud.gcloud_directory=$gcloud_directory -Dgcloud.version=$project_version -Dgcloud.promote=false

  # set a breakpoint
  # FIXME: do this without needing to know about the app's source structure
  # TODO clear existing breakpoints
  gcloud beta debug snapshots create $app_dir/src/main/java/com/sample/HelloServlet.java:35

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

