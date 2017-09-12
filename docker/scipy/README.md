# Scipy container for running Jupyter

Dockerized container for running Jupyter, using pip for package management.

Based on `midvalestudent/jupyter-base` with additional packages for scipy and
similarly sciency stuff.  Python 3 only.

Example usage:

```bash
PORT=8888 && \
docker run \
    -e NOTEBOOK_UID=$(id -u) \
    -e NOTEBOOK_GID=$(id -g) \
    -v nbconfig:/home/jovyan/.jupyter/nbconfig/ \
    -w $(pwd) \
    -v $(pwd):$(pwd) \
    -p $PORT:$PORT \
    -h $(hostname) \
    midvalestudent/jupyter-scipy:latest \
    start-notebook.sh --ip=$(hostname) --port=$PORT
```

This will run a notebook server using `$(pwd)` as the working directory.  New
notebooks will be created as the current user, and served on the (unprivileged)
port of the current host.  Change `$(hostname)` to `localhost` to serve locally.
