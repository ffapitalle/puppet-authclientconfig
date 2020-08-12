# Manage auth-client-config - pam and NSS profile switcher
#
# @summary This module manages to install auth-client-config and enable/disable auth profiles
#
# @param package_name set the package name
# @param package_ensure package version to install or present / absent
#
# @example
#   include authclientconfig
class authclientconfig (
  String $package_name,
  String $package_ensure,
) {
  package { $package_name:
    ensure => $package_ensure,
  }
}
