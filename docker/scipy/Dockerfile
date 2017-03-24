FROM midvalestudent/jupyter-base:latest

USER root
ENV HOME=/root

ADD requirements.txt /usr/local/share/requirements.txt
RUN pip install --upgrade pip && pip install -r /usr/local/share/requirements.txt

# Configure ipython kernel to use matplotlib inline backend by default
RUN mkdir -p $HOME/.ipython/profile_default/startup
ADD mplimporthook.py $HOME/.ipython/profile_default/startup/

# back to unprivilged user
ENV HOME=/home/$NB_USER

# Repeat for unprivileged user: Configure for matplotlib inline
RUN mkdir -p $HOME/.ipython/profile_default/startup
ADD mplimporthook.py $HOME/.ipython/profile_default/startup/

# startup scripts
USER root
ENV HOME=/root

ADD start-notebook.sh /usr/local/bin/start-notebook.sh
ADD scipy-notebook.sh /usr/local/bin/scipy-notebook.sh
