class dropbox::service {
  service { 'dropbox':
    ensure  => 'running',
    enabled => 'true',
  }
}
