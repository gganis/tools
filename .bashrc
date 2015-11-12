#
# Functions
function goroot () { . $HOME/etc/goroot.sh "$1"; }
function goxrd () { . $HOME/etc/xrd-env.sh "$1 $2"; }
function setroot () { . $HOME/etc/root-env.sh "$1 $2"; }
function setxrd () { . $HOME/etc/xrd-env.sh "$1 $2"; }
function setroottest () { . $HOME/etc/roottest-env.sh "$1 $2"; }
function addpath () { . $HOME/etc/addpath.sh "$1"; }
function cmakeprep () { . $HOME/etc/cmakeprep.sh "$1"; }

# Path
export PATH=$HOME/bin:$PATH

# Load in the git branch prompt script.
source ~/.git-prompt.sh

# Simple prompt
function custom_prompt
{
PS1="\h:\w\$(__git_ps1) \$ "
}
custom_prompt
