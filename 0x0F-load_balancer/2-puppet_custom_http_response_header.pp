# manifest to install nginx, set a custom header
# update apt
exec { 'update':
  command => '/usr/bin/apt-get update',
}

# ensure package nginx is intalled in the system
package { 'nginx':
  ensure => 'installed',
}

# make sure line for custom header is in the default file
file_line{ 'add_custom_header':
  path  => '/etc/nginx/sites-available/default',
  line  => "\tadd_header X-Served-By ${hostname};",
  after => 'root /var/www/html;',
}

# restart nginx
exec { 'restart':
  command => '/usr/sbin/service nginx restart',
}
