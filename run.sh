#!/bin/sh

set -e

test_dir="`dirname $0`/test/"
files=`find $test_dir -executable -type f`

gcloud info
gcloud auth list

for file in $files; do
  . $file 
done
