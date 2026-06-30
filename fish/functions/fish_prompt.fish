function fish_prompt
    set -l last_status $status
    set -l stat (set_color green)'λ '

    if test $last_status -ne 0
        set stat (set_color red)"($last_status) λ "(set_color --reset)
    end

    string join ' ' -- (set_color green) (prompt_pwd) (set_color --reset) $stat
end
