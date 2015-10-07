# == Class: other
#
# Install other support packages needed
#
class other {
  exec {'apt-get update':
    command => '/usr/bin/apt-get update',
  }
    
  $packages = ['libssl-dev']
  package { $packages:
    ensure  => present,
    require => Exec['apt-get update']
  }

}
