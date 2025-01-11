# XDG Directories
set -xg XDG_CONFIG_HOME $HOME/.config
set -xg XDG_CACHE_HOME $HOME/.cache
set -xg XDG_DATA_HOME $HOME/.local/share
set -xg XDG_STATE_HOME $HOME/.local/state
set -xg XDG_BIN_HOME $HOME/.local/bin

# Starship Prompt
function starship_transient_prompt_func
  starship module character
end

function starship_transient_rprompt_func
  starship module time
end

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
starship init fish | source
enable_transience

atuin init fish | source

#oh-my-posh init fish --config ~/.config/ohmyposh/p10k.toml | source

# set -xg EDITOR nvim
set -xg EDITOR zed

# aliasis
alias cd=z
alias la='eza -a --icons'
alias ls='eza --icons'
alias ll='eza -a -l --icons'
alias tree='eza -a -T --git-ignore --icons'
alias lta4="eza -lTag --git-ignore --level=4 --icons"
alias tmux='tmux -f ~/.tmux.conf'
alias branch='git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff --color=always {1} | delta" --pointer="" | xargs git checkout'
alias doom='~/.local/bin/doom'
alias rain="unimatrix -n -s 90 -l 'o'"
alias tty-time='tty-clock -sbc'
alias bonsai='cbonsai --seed 119 --live'
alias zed='flatpak run dev.zed.Zed'

set -x HOMEBREW_NO_ENV_HINTS 1

if test -d /home/linuxbrew/.linuxbrew

      set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
      set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
      set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
      set -gx PATH "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $PATH
      set -q MANPATH; or set MANPATH ''
      set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH
      set -q INFOPATH; or set INFOPATH ''
      set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH
      set -gx HOMEBREW_GITHUB_API_TOKEN {api token goes here, don't remember where that's created}
  else if test -d /opt/homebrew
      /opt/homebrew/bin/brew shellenv | source
end

# zoxide
zoxide init fish | source

# bat
set -gx BAT_THEME "base16-256" # base16-256, Dracula

# FZF
set -xg FZF_DEFAULT_COMMAND fd
set -xg FZF_DEFAULT_OPTS "--height=90% --layout=reverse --info=inline --border rounded --margin=1 --padding=1 \
--color=bg+:-1,gutter:-1,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--bind 'ctrl-u:preview-half-page-up'
--bind 'ctrl-d:preview-half-page-down'
--bind 'ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)'"
set -xg fzf_preview_dir_cmd eza --long --header --icons --all --color=always --group-directories-first --hyperlink
set -xg fzf_fd_opts --hidden --color=always
set -xg _ZO_FZF_OPTS $FZF_DEFAULT_OPTS '--preview "{$fzf_preview_dir_cmd} {2}"'

# nvims
#function neovims
#    set items (find $HOME/.config -maxdepth 2 -name "init.lua" -type f -execdir sh -c 'pwd | xargs basename' \;)
#    set selected (printf "%s\n" $items | fzf --prompt='   Neovim Configs ' --preview-window 'right:border-left:50%:<40(right:border-left:50%:hidden)' --preview 'lsd -l -A --tree --depth=1 --color=always --blocks=size,name ~/.config/{} | head -200')
#
#    if test -z "$selected"
#        return 0
#    else if test "$selected" = "nvim"
#        set selected ""
#    end
#
#    set NVIM_APPNAME $selected
#    nvim $argv
#end

# ollama
function ollama-serve
    ollama serve > /dev/null 2>&1 &
end

function ollama-kill
    pkill ollama
end

# backups
function backup --argument filename
    cp $filename $filename.bak
end

set -g fish_greeting ''
