# use execute to run a command
exec {'kill a process':
  command => '/usr/bin/pkill killmenow'}
