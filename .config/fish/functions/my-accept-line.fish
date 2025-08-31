function my-accept-line -d "Show Git status, if not, show list of files"  
  set --local cmd (commandline)
    if test -z "$cmd"
      if git rev-parse --git-dir > /dev/null 2>&1
        git status
      else
        echo .
        eza -l --icons
      end
    end
  commandline --function execute
end
