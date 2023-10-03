# manifest to install nginx, set a custom header
# update apt
exec { 'update':
  command => '/usr/bin/apt update'
}

# ensure package nginx is intalled in the system
package { 'nginx':
  ensure => 'installed'
}

# add homepage to be served
file { '/var/www/html/index.html':
  ensure  => 'file',
  content => 'Hello World!',
  mode    => '0644',
  require => Package['nginx']
}

# set redirection
file_line { 'Set 301 redirection':
  ensure   => 'present',
  path     => '/etc/nginx/sites-available/default',
  multiple => true,
  line     => "\trewrite ^/redirect_me/$ google.com permanent;",
  after    => 'root /var/www/html;',
  notify   => Exec['restart'],
  require  => File['/var/www/html/index.html']
}

# make sure line for custom header is in the default file
file_line{ 'add_custom_header':
  path  => '/etc/nginx/sites-available/default',
  line  => "\tadd_header X-Served-By ${hostname};",
  after => 'root /var/www/html;'
}

# restart nginx
exec { 'restart':
  command => '/usr/sbin/service nginx restart',
  require => Package['nginx']
}
