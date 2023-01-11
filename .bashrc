# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# load aliases from different file
. ~/.bash_aliases

# powerline shit
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

#Old PS1
#PS1='\n\u@\h \W > '
if [ "$(tty)" = /dev/tty1 ]; then
    exec startx
    headphones
fi


# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [ $WINDOWID -gt 1 ] && [ -z $transparency_set ]; then 
    transset-df --dec 0.2 --id "$WINDOWID" > /dev/null
    transparency_set=1
fi

# makes a newline
echo ""
neofetch

