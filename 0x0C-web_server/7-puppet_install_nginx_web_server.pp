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

exec { 'append_redirect_me':
  command => "/usr/bin/sed -i '/i^}$/i \\\n\tlocation \\/redirect_me {return 301 google.com;}' /etc/nginx/sites-available/default",
}

service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}
