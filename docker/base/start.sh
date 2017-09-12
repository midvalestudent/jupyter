#!/bin/bash

# exit if anything goes wrong
set -e

# Handle special flags if we're root
if [ $UID == 0 ]
then
    # Change userid and possibly the groupid of NB_USER
    if [ "$NOTEBOOK_UID" != $(id -u $NB_USER) ] \
        || [ "$NOTEBOOK_GID" != $(id -g $NB_USER) ]
    then
        groupmod -g $NOTEBOOK_GID $NB_GROUP
        usermod -u $NOTEBOOK_UID -g $NOTEBOOK_GID $NB_USER
    fi
    chown -R $NB_USER:$NB_GROUP /home/$NB_USER/.*

    # Exec the command as NB_USER
    echo "Running as UID:GID = $NOTEBOOK_UID:$NOTEBOOK_GID"
    exec su $NB_USER -c "env PATH=$PATH $*"
else
    # Exec the command as a regular user
    echo "WARNING: running as regular user; permissions may not be correct"
    exec $*
fi
