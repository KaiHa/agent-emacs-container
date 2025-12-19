# Only execute this file once per shell.
if [ -n "$__HOME_BASHRC_SOURCED" ]; then return; fi
__HOME_BASHRC_SOURCED=1

# We are not always an interactive shell.
if [ -n "$PS1" ]; then
    PROMPT_COMMAND=__prompt_command
__prompt_command ()
{
    local rc=$?
    if [[ rc -ne 0 ]]; then
        echo -e "bash: \e[0;31mexit $rc\e[0m"
    fi
}

HISTSIZE=20000
HISTCONTROL=ignorespace:erasedups

# Check the window size after every command.
shopt -s checkwinsize

# Disable hashing (i.e. caching) of command lookups.
set +h

# Provide a nice prompt if the terminal supports it.
if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
  PROMPT_DIRTRIM=5
  PROMPT_COLOR="1;31m"
  ((UID)) && PROMPT_COLOR="1;32m"
  if [ -n "$INSIDE_EMACS" ] || [ "$TERM" = "eterm" ] || [ "$TERM" = "eterm-color" ]; then
    # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
    # and also I prefer a non fancy prompt in Emacs
    PS1="\n\[\033[$PROMPT_COLOR\]\u@\h:\W/ \\$\[\033[0m\] "
  else
    PS1="\n\[\033[$PROMPT_COLOR\]╭─[\[\033[1;90m\]\u@\h:\[\033[$PROMPT_COLOR\]\w]\n\[\033[$PROMPT_COLOR\]╰─> \[\033[0m\]\[\e]0;\u@\h: \w\a\]"
  fi
  if test "$TERM" = "xterm"; then
    PS1="\[\033]2;\h:\u:\w\007\]$PS1"
  fi
fi

alias -- l='ls -alh'
alias -- ll='ls -l'
alias -- ls='ls --color=tty'

fi
