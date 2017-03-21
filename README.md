# Containers for running Jupyter

Dockerized containers for running Jupyter, as well as a git filter appropriate
for scrubbing notebook output cells so they don't end up in your history.

## Usage

Add the filter to your git project by running configure.sh.

Build docker containers of your choice using docker/docker-compose commands.
Before running any docker-compose commands, set up the environment by exporting
the variables listed in docker/env.sh.  Reasonable defaults can be set by
sourcing docker/env.sh.

The Dockerfile's aren't complicated, but do document nuances in building
various libraries and executables needed by each package.
