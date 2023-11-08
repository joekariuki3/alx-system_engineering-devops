# rectify file named wrongly in wp-settings.php file

# Define the file path
$filepath = '/var/www/html/wp-settings.php'

# Define the search and replace strings
$search_string = '.phpp'
$replace_string = '.php'

# Ensure the file exists and perform search and replace
file { $filepath:
  ensure  => file,
  content => file($filepath),
}

exec { 'search_replace':
  command => "/bin/sed -i 's/${search_string}/${replace_string}/1' ${filepath}",
  require => File[$filepath], # Ensure the file exists before executing the command
}
