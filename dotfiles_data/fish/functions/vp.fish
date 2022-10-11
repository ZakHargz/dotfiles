function vp -d "Fuzzy find and edit files within a given directory"
  if test (count $argv) -gt 0
    command $EDITOR $argv
  else
    fzf -m | xargs $EDITOR
  end
end