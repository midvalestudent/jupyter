FROM midvalestudent/jupyter/base:latest

USER root
ENV HOME=/root

ADD requirements.txt /usr/local/share/requirements.txt
RUN pip install -r /usr/local/share/requirements.txt

# back to unprivilged user
ENV HOME=/home/$NB_USER
