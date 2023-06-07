# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# load aliases from different file
. ~/.bash_aliases

# load fzf scripts
. /usr/share/fzf/completion.bash
. /usr/share/fzf/key-bindings.bash

# powerline shit
#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /usr/share/powerline/bindings/bash/powerline.sh

. ~/git-prompt.sh

make_prompt () { 
    if [ "$VIRTUAL_ENV" = "" ]; then
        local prompt_string="\[\e[48;5;032m\] \w \[\e[38;5;032m\e[49m\]";
    else
        local prompt_string="\[\e[48;5;002m\] 🐍 \w \[\e[38;5;002m\e[49m\]";
    fi;
    __git_ps1 "${prompt_string}" "\[\033[0m\]\n> "
}

PROMPT_COMMAND='make_prompt'
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTAT=1

#Old PS1
#PS1='\n\u@\h \W > '
if [ "$(tty)" = /dev/tty1 ]; then
    exec startx
    headphones
fi


# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [[ $WINDOWID -gt 1 ]] && [ -z $transparency_set ]; then 
    if [[ $TERM != "tmux-256color" ]]; then
        transset-df --dec 0.2 --id "$WINDOWID" > /dev/null
        transparency_set=1
    fi
fi

# makes a newline
echo ""
neofetch

[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
source /opt/ros/noetic/setup.bash
# autojump
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
