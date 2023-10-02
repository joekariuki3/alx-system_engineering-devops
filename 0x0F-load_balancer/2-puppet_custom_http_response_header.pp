# manifest to install nginx, should perform redirect 301

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
  before   => 'location / {',
  path     => '/etc/nginx/sites-available/default',
  multiple => true,
  line     => '\trewrite ^/redirect_me/ google.com permanent',
  notify   => Exec['restart nginx'],
  require  => File['/var/www/html/index.html']
  }

service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}

file_line { 'Set X-Served-By header':
  ensure   => 'present',
  after    => 'location / {',
  path     => '/etc/nginx/sites-available/default',
  multiple => true,
  line     => 'add_header X-Served-By \$hostname;'
  notify   => Exec['restart nginx'],
  require  => File['/var/www/html/index.html']
}

