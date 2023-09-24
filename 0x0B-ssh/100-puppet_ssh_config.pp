# using puppet to change ssh config file
file {'/etc/ssh/ssh_config':
  ensure  => present,
  content => "StrictHostKeyChecking ask\nIdentityFile ~/.ssh/school/nPasswordAuthentication no/n"
}
