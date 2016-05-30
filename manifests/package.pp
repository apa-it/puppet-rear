# Class: rear::package
#
# This module manages rear packages
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include rear::package
#
class rear::package {
  package { $rear::params::package_common: ensure => installed; }
}
