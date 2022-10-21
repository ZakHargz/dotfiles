function fo -d 'Fuzzy find files and open in editor'
  set files $(fzf-tmux --query="$argv[1]" --multi --select-1 --exit-0)
  if test $files
    $EDITOR "$files[1]"
  end
end
