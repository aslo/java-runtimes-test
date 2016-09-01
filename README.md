# Java Runtimes Tests
This repository contains integration tests for the Google Cloud Java runtimes. Tests are implemented as bash scripts. Tests should return a non-zero exit code to indicate failure, and an exit code of zero otherwise.

## Run the tests
To run the full test suite:
```
$ ./run.sh
```
This will run all scripts in the `test/` directory.

## Code style
* Shell scripts in this repo should follow the [Google Shell Style Guide](https://google.github.io/styleguide/shell.xml)
* Java code should follow the [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)    
