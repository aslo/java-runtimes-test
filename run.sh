#!/bin/sh

set -e

test_dir="`dirname $0`/test/"
files=`find $test_dir -executable -type f`

gcloud info
gcloud auth list

. ./helpers.sh

# build and push the runtimes under test
# TODO clone and build
echo 'Pushing the latest local images to gcr.io'
push_image openjdk8:latest openjdk8
push_image jetty9:latest jetty9

# run all tests
for file in ${files[@]}; do
  $file 
done
