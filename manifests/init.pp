class dropbox {
  include stdlib
  include dropbox::params

  anchor { 'dropbox::begin': }
  -> class { 'dropbox::package': }
  -> class { 'dropbox::config': } 
  ~> class { 'dropbox::service': }
  -> anchor { 'dropbox::end': }
}
