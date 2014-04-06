#
# Functions
function goroot () { . /home/ganis/etc/goroot.sh "$1"; }
function goxrd () { . /home/ganis/etc/xrd-env.sh "$1 $2"; }
function setroot () { . /home/ganis/etc/root-env.sh "$1 $2"; }
function setxrd () { . /home/ganis/etc/xrd-env.sh "$1 $2"; }
function setroottest () { . /home/ganis/etc/roottest-env.sh "$1 $2"; }
function addpath () { . /home/ganis/etc/addpath.sh "$1"; }

# Path
export PATH=/home/ganis/bin:$PATH

# Load in the git branch prompt script.
source ~/.git-prompt.sh

# Simple prompt
function custom_prompt
{
PS1="\h:\w\$(__git_ps1) \$ "
}
custom_prompt
