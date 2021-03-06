#Class: bmc
#
#
#
# Parameters:
# ensure:
# running:
# manage_repo:
# manage_gems: Should the module install the required gems
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class bmc(
  $ensure      = 'present',
  $running     = 'running',
  $manage_repo = false,
  $manage_gems = false,
) inherits bmc::params {

  if $ensure == 'present' or $ensure == 'latest' {
    Class['bmc::validate'] ->
    Class['bmc::install'] ->
    Class['bmc::config'] ~>
    Class['bmc::service'] ->
    Class['bmc::oem']
  } elsif $ensure == 'purged' or $ensure == 'absent' {
    Class['bmc::validate'] ->
    Class['bmc::oem'] ->
    Class['bmc::service'] ->
    Class['bmc::config'] ->
    Class['bmc::install']
  }

  contain 'bmc::validate'
  contain 'bmc::install'
  contain 'bmc::config'
  contain 'bmc::service'
  contain 'bmc::oem'
}