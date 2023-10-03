# manifest to install nginx, should perform redirect 301
exec { 'update package':
  command => '/usr/bin/apt update',
}

package { 'nginx':
  ensure => 'installed',
}

file { '/var/www/html/index.html':
  ensure  => 'file',
  content => 'Hello World!',
  mode    => '0644',
  require => Package['nginx'],
}

file_line { 'Set 301 redirection':
  ensure   => 'present',
  path     => '/etc/nginx/sites-available/default',
  multiple => true,
  line     => "\trewrite ^/redirect_me/$ google.com permanent;",
  after    => 'root /var/www/html;',
  notify   => Exec['restart nginx'],
  require  => File['/var/www/html/index.html']
  }

exec { 'restart nginx':
  command => '/usr/sbin/service nginx restart',
  require => Package['nginx']
}

service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}
