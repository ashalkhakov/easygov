#!/bin/bash -e

docker run -ti --rm \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v $HOME:/user \
        --net=host \
        --ipc=host \
        ashalkhakov/easygov:latest $@
