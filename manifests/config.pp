# Class: rear::config
#
# This module manages rear configuration
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include rear::config
#
class rear::config {

  # Check if url_with_domain is used
  if $rear::url_with_domain {
    $local_backup_url = "${rear::backup_url}/${::domain}"
    $local_output_url = "${rear::output_url}/${::domain}"
  } else {
    $local_backup_url = $rear::backup_url
    $local_output_url = $rear::output_url
  }

  # Setup configuration files
  file { $rear::params::config_local:
    ensure  => file,
    mode    => '0644',
    owner   => root,
    group   => root,
    path    => $rear::params::config_local,
    content => template($rear::params::config_local_template);
  }
}
