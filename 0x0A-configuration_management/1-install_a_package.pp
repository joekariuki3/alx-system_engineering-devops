# install flask 2.1.1 using pip3
exec { 'install flask 2.1.1':
  command => '/usr/bin/pip3 install flask==2.1.1',
  path    => ['/usr/bin/'],
  unless  => '/usr/bin/pip3 show Flask | grep -q "Version: 2.1.1"',
}
