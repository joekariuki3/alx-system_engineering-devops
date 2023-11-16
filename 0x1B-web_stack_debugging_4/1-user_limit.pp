# increase number of files user holberton can be able to open

# Define the file path
$filepath = '/etc/security/limits.conf'

# Define the search and replace strings
$search_string = 'holberton hard nofile 5'
$search_string2 = 'holberton soft nofile 4'
$replace_string = 'holberton hard nofile 4096'
$replace_string2 = 'holberton soft nofile 4096'

# Ensure the file exists and perform search and replace
file { $filepath:
  ensure  => file,
  content => file($filepath),
}

exec { 'search_replace':
  command => "/bin/sed -i 's/${search_string}/${replace_string}/1' ${filepath}",
  require => File[$filepath], # Ensure the file exists before executing the command
}
exec { 'search_replace2':
  command => "/bin/sed -i 's/${search_string2}/${replace_string2}/1' ${filepath}",
  require => File[$filepath], # Ensure the file exists before executing the command
}
