#!/bin/bash

# exit if anything goes wrong
set -e

# Handle special flags if we're root
if [ $UID == 0 ]
then
    # Change userid and possibly the groupid of NB_USER
    if [ "$NOTEBOOK_UID" != $(id -u $NB_USER) ]
    then
        if [ "$NOTEBOOK_GID" != $(id -g $NB_USER) ]
        then
            groupadd -f -g $NOTEBOOK_GID $NB_GROUP
            usermod -u $NOTEBOOK_UID -g $NOTEBOOK_GID $NB_USER
        else
            usermod -u $NOTEBOOK_UID $NB_USER
        fi
        chown $NB_USER:$NB_GROUP /$HOME/.jupyter/
    fi

    # Exec the command as NB_USER
    echo "Running as UID:GID = $NOTEBOOK_UID:$NOTEBOOK_GID"
    exec su $NB_USER -c "env PATH=$PATH $*"
else
    # Exec the command as a regular user
    exec $*
fi
