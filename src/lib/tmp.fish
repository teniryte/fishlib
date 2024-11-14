function tmpCopy -a filename;
  set baseFilename (basename $filename);
  set stamp (stamp);
  set tmpFile "$tmpDir/$baseFilename.$stamp";
  cp -r $filename $tmpFile;
  set -xg originalTempFile (realpath $filename);
  set -xg savedTempFile $tmpFile;
  # echo "Copied: $originalTempFile";
  # echo "  > $tmpFile";
end;

function tmpMove;
  tmpCopy $argv;
  rm -rf $originalTempFile;
  echo $savedTempFile;
end;

function tmpRestore;
  rm -rf $originalTempFile;
  cp -r $savedTempFile $originalTempFile;
  # echo "Restored: $savedTempFile";
  # echo "  > $originalTempFile";
end;
