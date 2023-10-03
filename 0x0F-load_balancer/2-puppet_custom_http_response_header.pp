# manifest to install nginx, set a custom header

package { 'nginx':
  ensure => 'installed',
}

augeas { 'nginx_add_custom_header':
  context => '/etc/nginx/sites-available/default',
  changes => ['set add_header[last()+1] X-Served-By $hostname'],
  require => Package['nginx'],
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
