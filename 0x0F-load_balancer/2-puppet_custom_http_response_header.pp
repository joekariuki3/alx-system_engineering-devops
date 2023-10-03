# manifest to install nginx, set a custom header

# ensure package nginx is intalled in the system
package { 'nginx':
  ensure => 'installed',
}

# get ststem hostname using facter variable
$system_hostname = $::hostname

# make sure line for custom header is in the default file
file_line{ 'add_custom_header':
  path  => '/etc/nginx/sites-available/default',
  line  => "\tadd_header X-Served-By ${system_hostname}",
  after => 'root /var/www/html;',
}

# ensure nginx service is running and it is enabled
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
