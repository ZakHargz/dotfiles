set SESSION_FILE ~/.bws-session

function bwl -d "Unlocks bitwarden vault and stores session in file"
  if test -e $SESSION_FILE
    set -x BW_SESSION (cat $SESSION_FILE)
  end

  if ! bw status | grep unlocked > /dev/null
    set -x BW_SESSION (bw unlock --raw)
    if test $status -ne 0
      echo "bw unlock failed"
      return $status
    else
      echo $BW_SESSION > $SESSION_FILE
    end
  end
end

function bws -d "Bitwarden password search using FZF"
  if command -sq bw and command -sq fzf and command -sq xclip
        bwl
        bw sync
        bw get item (
            bw list items \
            | jq -r '.[] | [.name, .login.username // "", .id] | @tsv' \
            | column -t -s \t \
            | fzf --with-nth 1..-2 --preview-window down:2 \
                       --preview 'bw get item (echo {} | awk \'{print $NF}\') | jq -r \'.login.uris | .[] | .uri // empty \'' \
            | awk '{print $NF}'
        ) | jq -r '.login.password' | pbcopy
    end
end

function bw-pass -d "Generate new password from Bitwarden"
  bwl
  bw generate -lusn --length 18
end

function bw-passp -d "Generate a new password from Bitwarden (Passphrase)"
  bwl
  bw generate --passphrase --words 3 --separator - --includeNumber --capitalize
end
