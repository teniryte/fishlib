set workDir "$HOME/work";
set tmpDir $workDir/tmp;
set tmpDownloadedDir "$tmpDir/.downloaded";

set storeUrl 'https://store.flaux.ru';
set fishUrl "$storeUrl/shell/fish";
set runScopes 'script' 'lib';

function makeDir -a dirname option;
  if test "$option" = '-r';
    rm -rf $dirname;
  end;
  if test -d "$dirname";
  else;
      mkdir $dirname;
  end;
end;

makeDir $workDir;
makeDir $tmpDir -r;
makeDir $tmpDownloadedDir;

function fileExt -a filename;
  echo (string match -r '.*\.([^.]+)$' -- $filename)[2];
end;

function urlProtocol -a url;
  echo (string match -r '^([^/]+)//' -- $url)[1];
end;

function tmpDownload -a url option;
  set name (basename $url);
  set st (stamp);
  set ext $name;
  set tempFile "$tmpDownloadedDir/$name.$st.$ext";

  makeDir $tmpDownloadedDir;

  wget -q -O $tempFile $url;

  if test "$option" = '-s';
      set -xg downloadedTempFile $tempFile;
  else;
      echo $tempFile;
  end;
end;

function runRemote -a url scope;
  tmpDownload "$url" -s;
  runLocal $downloadedTempFile;
end;

function runLocal -a filename;
  set ext (fileExt $filename);

  if test "$ext" = 'fish';
      source $filename;
  end;

  if test "$ext" = 'sh';
      bash $filename;
  end;

  if test "$ext" = 'bash';
      bash $filename;
  end;
end;

function run -a scope filename;
  if contains -- $scope $runScopes;
      if contains -- $filename $runScopes;
          set temp $scope;
          set scope $filename;
          set filename $temp;
      end;
  else;
      set temp $scope;
      set scope $filename;
      set filename $temp;
  end;

  set ext (fileExt $filename);

  if test "$ext" = '';
      set filename "$filename.fish";
  end;

  if contains -- $scope $runScopes;
      set filename "$fishUrl/$scope/$filename";
  end;

  set start (urlProtocol $filename)

  if test "$start" = 'https://';
      runRemote $filename $scope;
  else;
      runLocal $filename $scope;
  end;
end;

function stamp;
  echo (date +"%Y-%m-%d-%H-%M-%S-%3N");
end;

run lib tmp;
run lib common;
run lib git;
