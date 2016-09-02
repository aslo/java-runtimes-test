# Java Runtimes Tests
This repository contains integration tests for the Google Cloud Java runtimes. Tests are implemented as bash scripts.

## Setup
1. Create a test project on the Google Cloud Console and enable billing.
2. Install the [Google Cloud SDK](https://cloud.google.com/sdk/docs/)
3. Run `gcloud init` to authenticate and configure the Google Cloud SDK.

## Run the tests
To run the full test suite:
```
$ ./run.sh
```
This will run all scripts in the `test/` directory. This script returns a non-zero exit code to indicate failure, and an exit code of zero otherwise.

## Code style
* Shell scripts in this repo should follow the [Google Shell Style Guide](https://google.github.io/styleguide/shell.xml)
* Java code should follow the [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
