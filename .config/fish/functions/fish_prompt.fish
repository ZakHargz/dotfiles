# function fish_prompt -d "Prints left prompt"
#     set -l last_status  $status
#     set -l glyph        "\$"
#     set -l glyph_color  (set_color normal)
#     set -l pwd          (prompt_pwd)
#     set -l pwd_color    (set_color blue)
#
#     if test (id -u "$USER") -eq 0
#         set glyph "#"
#     end
#
#     if test "$last_status" -ne 0
#         set pwd_color (set_color red)
#     end
#
#     if command git rev-parse --git-dir > /dev/null 2>/dev/null
#         if ! command git diff --cached --no-ext-diff --quiet --exit-code 2>/dev/null
#             set glyph_color (set_color green)
#         else if command git rev-parse --verify --quiet refs/stash > /dev/null 2>/dev/null
#             set glyph_color (set_color yellow)
#         end
#     end
#
#     printf "$pwd_color$pwd $glyph_color$glyph "
# end
#



function fish_prompt
    if test -n "$SSH_TTY"
        echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end

    echo -n (set_color blue)(prompt_pwd)' '

    set_color -o
    if fish_is_root_user
        echo -n (set_color red)'# '
    end
    echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
    set_color normal

	if set -q VIRTUAL_ENV
    echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
	end
end
