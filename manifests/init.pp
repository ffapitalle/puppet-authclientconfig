# Manage auth-client-config - pam and NSS profile switcher
#
# @summary This module manages to install auth-client-config and enable/disable auth profiles
#
# @example
#   include authclientconfig
class authclientconfig (
  $package_name,
  $package_ensure,
) {
  package { $package_name:
    ensure => $package_ensure,
  }
}
