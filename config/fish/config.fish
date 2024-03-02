if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    #neofetch
    macchina
    starship init fish | source
    zoxide init fish | source
#    set HELIX_RUNTIME /var/lib/helix/runtime/
end

#status is-login; and pyenv init --path | source
#status is-interactive; and pyenv init - | source

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin

export VISUAL=helix
export EDITOR=helix
export BAT_THEME=gruvbox-light

