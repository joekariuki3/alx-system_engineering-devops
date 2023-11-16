# increase file descriptor limit for nging to handle more requests

# Define the file path
$filepath = '/etc/default/nginx'

# Define the search and replace strings
$search_string = 'ULIMIT="-n 15"'
$replace_string = 'ULIMIT+"-n 4096"'

# Ensure the file exists and perform search and replace
file { $filepath:
  ensure  => file,
  content => file($filepath),
}

exec { 'search_replace':
  command => "/bin/sed -i 's/${search_string}/${replace_string}/1' ${filepath}",
  require => File[$filepath], # Ensure the file exists before executing the command
}
exec { 'restart_nginx':
  command => '/usr/sbin/service nginx restart',
  require => Exec['search_replace']
}
