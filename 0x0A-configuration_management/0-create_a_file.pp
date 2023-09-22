# create a file school in temp and add some contetnt also make sure is in certain group and owner
file{'/tmp/school':
  ensure  => present,
  mode    => '0744',
  owner   => 'www-data',
  group   => 'www-data',
  content => 'I love Puppet',
}
