function accept_line -d "Pressing enter will either do a LS or show Git Status"
  set --local cmd (commandline)
    if test -z "$cmd"
      if git rev-parse --git-dir > /dev/null 2>&1
        echo ""
        git status
      else
        echo ""
        k
      end
    end
  commandline --function execute
end
