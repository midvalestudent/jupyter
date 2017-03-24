#!/bin/bash

python -c "import matplotlib.pyplot"
exec jupyter notebook $*
