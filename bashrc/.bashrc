# This file is currently a work in progress. I have also started an alias file. I will probably seperate all of these files 
# in such a way to make them a bit more organized.

source ~./$HOME/.alias
source ~./$HOME/.functions
source ~./$HOME/.profile

<<<<<<< HEAD

=======
# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
>>>>>>> 121206f78e5075e92df7ae4c45c67a67768e058f
