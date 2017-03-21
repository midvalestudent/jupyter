#!/usr/bin/env python

"""
From: https://gist.github.com/pbugnion/ea2797393033b54674af
Adapted to suit ipython 4

Suppress output and prompt numbers in git version control.
This script will tell git to ignore prompt numbers and cell output
unless their metadata contains:
    "git" : { "keep_outputs" : true }
The notebooks themselves are not changed.
See also this blogpost: http://pascalbugnion.net/blog/ipython-notebooks-and-git.html.
Usage instructions
==================
1. Put this script in a directory that is on the system's path.
   For future reference, I will assume you saved it in 
   `~/scripts/ipynb_drop_output`.
2. Make sure it is executable by typing the command
   `chmod +x ~/scripts/ipynb_drop_output`.
3. Register a filter for ipython notebooks by
   putting the following line in `~/.config/git/attributes`:
   `*.ipynb  filter=clean_ipynb`
4. Connect this script to the filter by running the following 
   git commands:
   git config --global filter.clean_ipynb.clean ipynb_drop_output
   git config --global filter.clean_ipynb.smudge cat

To tell git to keep the output and prompts for a notebook,
open the notebook's metadata (Edit > Edit Notebook Metadata). A
panel should open containing the lines:
    {
        "name" : "",
        "signature" : "some very long hash"
    }
Add an extra line so that the metadata now looks like:
    {
        "name" : "",
        "signature" : "don't change the hash, but add a comma at the end of the line",
        "git" : { "keep_outputs" : true }
    }

You may need to "touch" the notebooks for git to actually register a change, if
your notebooks are already under version control.
"""

import sys
import json

nb = sys.stdin.read()

json_in = json.loads(nb)

keep_outputs = False
nb_metadata = json_in["metadata"]
try:
    keep_outputs = nb_metadata['git']['keep_outputs']
except KeyError:
    # the key doesn't exist, so don't keep outputs
    pass
if keep_outputs:
    sys.stdout.write(nb)

def strip_output_from_cell(cell):
    if "outputs" in cell:
        cell["outputs"] = []
    if "execution_count" in cell:
        cell["execution_count"] = None
    if "prompt_number" in cell:
        cell["prompt_number"] = None

ipy_version = int(json_in["nbformat"])-1 # nbformat is 1 more than actual version.

if ipy_version == 2:
    for sheet in json_in["worksheets"]:
        for cell in sheet["cells"]:
            strip_output_from_cell(cell)
else:
    for cell in json_in["cells"]:
        strip_output_from_cell(cell)

json.dump(json_in, sys.stdout, sort_keys=True, indent=1, separators=(",",": "))
