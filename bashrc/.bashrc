# This file is currently a work in progress. I have also started an alias file. I will probably seperate all of these files 
# in such a way to make them a bit more organized.

source ~./$HOME/.alias
source ~./$HOME/.functions
source ~./$HOME/.profile

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

