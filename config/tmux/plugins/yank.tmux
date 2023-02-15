}

# `yank_without_newline` binding isn't intended to be used by the user. It is
# a helper for `copy_line` command.
set_copy_mode_bindings() {
    local copy_command="$1"
    local copy_wo_newline_command
    copy_wo_newline_command="$(clipboard_copy_without_newline_command "$copy_command")"
    local copy_command_mouse
    copy_command_mouse="$(clipboard_copy_command "true")"
    if tmux_is_at_least 2.4; then
        tmux bind-key -T copy-mode-vi "$(yank_key)" send-keys -X "$(yank_action)" "$copy_command"
        tmux bind-key -T copy-mode-vi "$(put_key)" send-keys -X copy-pipe-and-cancel "tmux paste-buffer"
        tmux bind-key -T copy-mode-vi "$(yank_put_key)" send-keys -X copy-pipe-and-cancel "$copy_command; tmux paste-buffer"
        tmux bind-key -T copy-mode-vi "$(yank_wo_newline_key)" send-keys -X "$(yank_action)" "$copy_wo_newline_command"
        if [[ "$(yank_with_mouse)" == "on" ]]; then
            tmux bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X "$(yank_action)" "$copy_command_mouse"
        fi

        tmux bind-key -T copy-mode "$(yank_key)" send-keys -X "$(yank_action)" "$copy_command"
        tmux bind-key -T copy-mode "$(put_key)" send-keys -X copy-pipe-and-cancel "tmux paste-buffer"
        tmux bind-key -T copy-mode "$(yank_put_key)" send-keys -X copy-pipe-and-cancel "$copy_command; tmux paste-buffer"
        tmux bind-key -T copy-mode "$(yank_wo_newline_key)" send-keys -X "$(yank_action)" "$copy_wo_newline_command"
        if [[ "$(yank_with_mouse)" == "on" ]]; then
            tmux bind-key -T copy-mode MouseDragEnd1Pane send-keys -X "$(yank_action)" "$copy_command_mouse"
        fi
    else
        tmux bind-key -t vi-copy "$(yank_key)" copy-pipe "$copy_command"
        tmux bind-key -t vi-copy "$(put_key)" copy-pipe "tmux paste-buffer"
        tmux bind-key -t vi-copy "$(yank_put_key)" copy-pipe "$copy_command; tmux paste-buffer"
        tmux bind-key -t vi-copy "$(yank_wo_newline_key)" copy-pipe "$copy_wo_newline_command"
        if [[ "$(yank_with_mouse)" == "on" ]]; then
            tmux bind-key -t vi-copy MouseDragEnd1Pane copy-pipe "$copy_command_mouse"
        fi

        tmux bind-key -t emacs-copy "$(yank_key)" copy-pipe "$copy_command"
        tmux bind-key -t emacs-copy "$(put_key)" copy-pipe "tmux paste-buffer"
        tmux bind-key -t emacs-copy "$(yank_put_key)" copy-pipe "$copy_command; tmux paste-buffer"
        tmux bind-key -t emacs-copy "$(yank_wo_newline_key)" copy-pipe "$copy_wo_newline_command"
        if [[ "$(yank_with_mouse)" == "on" ]]; then
            tmux bind-key -t emacs-copy MouseDragEnd1Pane copy-pipe "$copy_command_mouse"
        fi
    fi
}

set_normal_bindings() {
    tmux bind-key "$(yank_line_key)" run-shell -b "$SCRIPTS_DIR/copy_line.sh"
    tmux bind-key "$(yank_pane_pwd_key)" run-shell -b "$SCRIPTS_DIR/copy_pane_pwd.sh"
}

main() {
    local copy_command
    copy_command="$(clipboard_copy_command)"
    error_handling_if_command_not_present "$copy_command"
    set_copy_mode_bindings "$copy_command"
    set_normal_bindings
}
main
