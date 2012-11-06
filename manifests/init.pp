# == Class: nscd
#
# Configure nscd on a Linux system.
#
# Supports Ubuntu; tested on 12.04.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  include nscd
#
# === Authors
#
# Andrew Leonard
#
# === Copyright
#
# Copyright 2012 Andrew Leonard, Seattle Biomedical Research Institute
#
class nscd {

  case $::operatingsystem {
    ubuntu: {
      case $::operatingsystemrelease {
        12.04: {
          $pkg = 'unscd'
          $svc = 'unscd'
        }
        default: {
          $pkg = 'nscd'
          $svc = 'nscd'
        }
      }
    }
    default: {
      fail("Module ${module_name} is not supported n ${::operatingsystem}")
    }
  }

  package { $pkg: ensure => installed }

  service { 'nscd':
    enable  => true,
    name    => $svc,
    require => Package[$pkg],
  }

}
