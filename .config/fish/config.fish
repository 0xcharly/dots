if status is-interactive
    set fish_greeting # Disable greeting message.
    set -g fish_term24bit 1 # Enable true color support.

    test -x /opt/homebrew/bin/brew && eval (/opt/homebrew/bin/brew shellenv)
    test -d $HOME/.local/bin && fish_add_path $HOME/.local/bin

    set -gx EDITOR (which nvim)
    set -gx VISUAL $EDITOR
    set -gx SUDO_EDITOR $EDITOR

    set -Ux BAT_THEME base16
    set -e FZF_DEFAULT_OPTS
    set -Ux FZF_DEFAULT_OPTS "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
    set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
    set -gx PATH $HOME/.cabal/bin $PATH $HOME/.ghcup/bin # ghcup-env

    set -Ux HOMEBREW_NO_AUTO_UPDATE 1
    set -Ux HOMEBREW_BUNDLE_FILE "$HOME/.config/brew/Brewfile"
    set -Ux MANPAGER "nvim +Man!"

    bind \cf ~/.local/bin/open-tmux-workspace
    bind -M insert \cf ~/.local/bin/open-tmux-workspace

    alias dots "vcsh dots"
    if type -q eza
        alias ls eza
    end

    function fish_mode_prompt
    end

    function fish_prompt
        print_pwd
        set_color "#a6adc8"
        set_color -b "#313244"
        printf " %s " (date '+%H:%M:%S')
        set_color normal
        printf " "
    end

    function print_pwd
        set -l pwd (pwd)
        set -l whoami (whoami)
        string match -rq "/google/src/cloud/$whoami/(?<citc_space>[a-zA-Z0-9_-]+)/google3" (pwd)
        if test -n "$citc_space"
            # Rename the current tab.
            title $citc_space

            set_color --bold "#1e1e2e"
            set_color --background "#89b4fa"
            printf " $citc_space "
        else if set -q VIRTUAL_ENV
            set -l pwd_segment_bg_color "#b4befe"

            set_color --bold "#1e1e2e"
            set_color -b $pwd_segment_bg_color
            printf " %s " (basename $VIRTUAL_ENV)
        else
            set -l pwd_segment_bg_color "#a6e3a1"
            fish_is_root_user; and set pwd_segment_bg_color "#f38ba8"

            set_color --bold "#1e1e2e"
            set_color -b $pwd_segment_bg_color
            printf " %s " (prompt_pwd)
        end
    end
end
