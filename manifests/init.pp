# Class: rear
# ===========================
#
# This module install Relax and Recover (REAR) on the local node.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `output`
#   Backup method that is used
#   Default value is ISO
#
# * `output_url`
#   Backup target that is used for backup method
#   Default value is 'nfs://192.168.0.1/srv/rear'
#
# * `backup`
#   Backup method that is used
#   Default value is NETFS
#
# * `backup_url`
#   Backup target that is used for backup method
#   Default value is 'nfs://192.168.0.1/srv/rear'
#
# * `ssh_root_password`
#   Password that could be used to log into the recover live image as root
#   Default value is 'Recover!N0W'

# * `schedule`
#   Backup frequency (daily, weekly or monthly)
#   Default value is none
#
# Variables
# ----------
#
# No additonal variables are required for this module
#
# Examples
# --------
#
# @example
#    class { 'rear':
#      output_url => 'nfs://192.168.100.1/backup/rear',
#      backup_url => 'nfs://192.168.100.1/backup/rear',
#      schedule => 'weekly'
#    }
#
# Authors
# -------
#
# Thomas Bendler <project@bendler-net.de>
#
# Copyright
# ---------
#
# Copyright 2016 Thomas Bendler, unless otherwise noted.
#
class rear (
  $output            = $rear::params::output,
  $output_url        = $rear::params::output_url,
  $backup            = $rear::params::backup,
  $backup_url        = $rear::params::backup_url,
  $ssh_root_password = $rear::params::ssh_root_password,
  $schedule          = $rear::params::schedule
) inherits rear::params {

  # Start workflow
  if $rear::params::linux {
    # Containment
    contain rear::package
    contain rear::config
    contain rear::service

    # Include classes
    Class['rear::package'] ->
    Class['rear::config'] ->
    Class['rear::service']
  }
  else {
    warning('The current operating system is not supported!')
  }
}
