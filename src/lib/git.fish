function st;
  git status;
end;

function nb -a name;
  set current (git branch --show-current);
  git checkout master;
  git branch -D $current;
  git pull;
  git checkout -b $name;
end;

function nbt -a name;
  set current (git branch --show-current);
  git checkout master;
  git branch -D $current;
  git pull;
  git checkout -- test;
  git pull;
  git checkout -b $name;
end;

function gitAddFiles;
  set argsCount (count $argv);
  if test "$argsCount" = '0';
      git add . --all;
  else;
      for arg in $argv;
          git add $arg;
      end;
  end;
end;

function gitGetBranch;
  echo (git branch --show-current);
end;

function gitCommit -a message;
  gitAddFiles $argv[2..-1];
  git commit -m $message;
end;

function gitPush;
  set branchName (gitGetBranch);
  git push --set-upstream origin $branchName;
end;

function diff;
  git diff $argv;
end;

function sth;
  git stash;
end;

function stha;
  git stash apply;
end;

function gitLog;
  git log --decorate --color --pretty=format:'%C(black)%h %C(black)%d %n  %C(blue)<%an> %C(blue)(%cr) %n  %C(white)%s';
end;

# alias lg gitLog;
function lg;
  git log --format='%C(auto)%h %Creset %s %C(green)%aN - %C(blue)%ar' --graph
end;

function p -a message;
  if test -f "$gitExclude";
      echo "Backing up $gitExclude...";
      tmpCopy $gitExclude;
      git checkout $gitExclude;
  end;
  gitCommit $message;
  gitPush;
  if test -f "$gitExclude";
      tmpRestore;
      echo "$gitExclude restored.";
  end;
end;

function com -a message;
  if test "$message" = '';
    echo "usage: com 'my commit' file1 file2";
  else;
    set files $argv[2..];
    set filesCount (count $files);
    if test "$filesCount" = '0';
      set files . --all;
    end;
    git add $files;
    git commit -m $message;
  end;
end;

function clearStash;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
  git stash drop;
end;

function checkout -a name;
  if test $name = 'm';
    set argv 'master';
  end;
  git checkout $argv;
end;

alias pu 'git pull';

alias re 'git rebase';

alias rmb 'br -d -f';

alias ck 'checkout';

alias br 'git branch';

alias c com;
