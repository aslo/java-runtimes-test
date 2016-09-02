#!/bin/sh
#
# Tests cloud debugger integration

set -e

project_root=`dirname $0`/..
sample_app="$project_root/fixtures/sample-app"
declare -a runtimes=("openjdk" "jetty")

source $project_root/helpers.sh

# TODO grep this from deploy output
project=`get_active_project`
project_url_suffix="$project.appspot.com"
project_version="debugger-test"
deployed_service_url="https://$project_version-dot-$project_url_suffix"

for runtime in ${runtimes[@]}; do
  deploy $runtime $sample_app $project_version

  # TODO clear existing breakpoints

  # set a breakpoint
  # FIXME: do this without needing to know about the app's source structure
  gcloud beta debug snapshots create $app_dir/src/main/java/com/sample/HelloServlet.java:35 --target $project_version

  # exercise the breakpoint
  curl $deployed_service_url

  # verify that the breakpoint has been hit
  # TODO
  #gcloud beta debug snapshots list ...
done

