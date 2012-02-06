class dropbox::package {
  Exec {
    path   => '/bin:/sbin:/usr/bin:/usr/sbin',
    unless => 'test -d ~${dropbox::params::dx_uid}/.dropbox-dist',
  }

  $download_arch = $::architecture ? {
    'i386'   => 'x86',
    'x86_64' => 'x86_64',
  }

  user { $dropbox::params::dx_uid:
    ensure     => 'present',
    managehome => 'true',
    comment    => 'Dropbox Service Account',
  }
  group { $dropbox::params::dx_gid:
    ensure => 'present',
  }

  exec { 'download-dropbox':
    command => "wget -O /tmp/dropbox.tar.gz \"http://www.dropbox.com/download/?plat=lnx.${download_arch}\"",
    require => User[$dropbox::params::dx_uid],
  }
  exec { 'install-dropbox':
    command => 'tar -zxvf /tmp/dropbox.tar.gz -C ~${dropbox::params::dx_uid}',
    require => Exec['download-dropbox'],
  }
  file { '/tmp/dropbox.tar.gz':
    ensure  => 'absent',
    require => Exec['install-dropbox'],
  }
}
