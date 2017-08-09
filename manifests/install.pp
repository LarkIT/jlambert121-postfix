# Class: postfix::install
#
# Manges the postfix package.  Not intended to be called directly
#
#
class postfix::install (
  $tls          = $::postfix::tls,
  $tls_package  = $::postfix::tls_package,
  $sasl_package = $::postfix::sasl_package,
) {

  package { 'sendmail':
    ensure  => absent,
    require => Package['postfix'],
  }

  package { 'postfix':
    ensure => present,
    notify => Class['postfix::service'],
  }

  if ( $postfix::install::tls and $postfix::install::tls_package ) {
    package { $postfix::install::tls_package:
      ensure => present,
    }
  }

  if ( $postfix::relay_username and $postfix::relay_password and $sasl_package ) {
    package { $sasl_package:
      ensure => present,
    }
  }
}
