function k -d "Better alternative to ls -lah"
  if type -q lsd
    lsd --icon always --icon-theme fancy -Al $argv
  else if type -q tree
    tree --dirsfirst -aFCNL 1 ./
  else
    ls -l $argv
  end
end