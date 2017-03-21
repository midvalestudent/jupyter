#!/bin/bash

# Run through the caffe mnist tutorial

cd $CAFFE_ROOT

# set solver mode to CPU
sed -i 's/mode:\ GPU$/mode: CPU/' ./examples/mnist/lenet_solver.prototxt

# get the mnist dataset
./data/mnist/get_mnist.sh

# prep the mnist data for training
./examples/mnist/create_mnist.sh

# train
./examples/mnist/train_lenet.sh

