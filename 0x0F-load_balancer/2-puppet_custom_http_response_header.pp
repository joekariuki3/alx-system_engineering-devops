# manifest to install nginx, set a custom header
exec { 'update':
  command => '/usr/bin/apt update',
}
package { 'nginx':
  ensure => 'installed',
}

file { '/var/www/html/index.html':
  ensure  => 'present',
  content => 'Hello World!',
  mode    => '0644',
  require => Package['nginx'],
}

file_line { 'Set 301 redirection':
  ensure   => 'present',
  path     => '/etc/nginx/sites-available/default',
  multiple => true,
  line     => "\trewrite ^/redirect_me https://google.com permanent;",
  after    => 'root /var/www/html;',
  notify   => Exec['restart'],
  require  => File['/var/www/html/index.html'],
}

file { '/etc/nginx/sites-available/default':
  ensure => 'present',
  mode   => '0644',
}

file_line{ 'add_custom_header':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  line    => "\tadd_header X-Served-By ${hostname};",
  after   => 'root /var/www/html;',
  notify  => Exec['restart'],
  require => File['/etc/nginx/sites-available/default'],
}

exec { 'restart':
  command => '/usr/sbin/service nginx restart',
  require => Package['nginx'],
}
