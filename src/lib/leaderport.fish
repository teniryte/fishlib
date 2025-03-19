function b;
  cd $HOME/work/leaderport/back;
  # killPort 9001;
  # yarn start:dev;
end;

function f;
  cd $HOME/work/leaderport/front;
  # killPort 9002;
  # yarn dev;
end;

function a;
  cd $HOME/work/leaderport/admin;
  # killPort 9003;
  # yarn dev;
end;

function d;
  cd $HOME/work/leaderport/dashboard;
  # killPort 9005;
  # yarn start;
end;

function f2;
  cd $HOME/work/leaderport/front-v2;
end;

function a2;
  cd $HOME/work/leaderport/admin2;
end;



function r;
  set name (basename (pwd));
  set success 'f';
  if test "$name" = 'back';
      yarn start:dev;
      set success 't';
  end;
  if test "$name" = 'front';
      yarn dev;
      set success 't';
  end;
  if test "$name" = 'admin';
      yarn dev;
      set success 't';
  end;
  if test "$name" = 'admin2';
      yarn dev;
      set success 't';
  end;
  if test "$name" = 'dashboard';
      yarn start;
      set success 't';
  end;
  if test "$success" = 'f';
  yarn dev;
  end;
end;
