# Start configuration added by Zim install {{{
#
# User configuration sourced by login shells
#

# Initialize Zim
source ${ZIM_HOME}/login_init.zsh -q &!
# }}} End configuration added by Zim install


### SSH-agent ###
if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check for a currently running instance of the agent
   RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
   if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> $HOME/.ssh/ssh-agent
   fi
   eval `cat $HOME/.ssh/ssh-agent`
fi

ssh-add $HOME/.ssh/id_rsa


### install zimfw

if [[ ! -f $HOME/.zim/zimfw.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}zimfw%F{220} Zsh configuration framework (%F{33}zimfw/zimfw%F{220})…%f"
    command mkdir -p "$HOME/.zim" && command chmod g-rwX "$HOME/.zim"
    command curl -fsSL https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh > "$HOME/.zim/zimfw.zsh" && \
        zsh ~/.zim/zimfw.zsh install || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

