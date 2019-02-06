# Defines a pam and NSS profile
#
# @summary Defines and enable or disable a pam and NSS profile
#
# @example
#   authclientconfig::profile { 'profile_name': 
#     source => "puppet:///my_module/example_profile",
#   }
define authclientconfig::profile (
  $profile     = $name,
  $profile_dir = '/etc/auth-client-config/profile.d/',
  $source      = undef,
  $enabled     = true,
) {

  unless $source {
    fail("Source not defined for ${name} ${profile}")
  }

  contain authclientconfig

  $action = bool2str($enabled, "enable", "disable")

  file { "profile_${profile}":
    path   => "${profile_dir}/${profile}-acc-profile",
    source => $source,
    notify => Exec["${action}_profile"],
  }

  exec { 'enable_profile':
    command => "/usr/sbin/auth-client-config -p ${profile} -t nss",
    refreshonly => true,
  }

  exec { 'disable_profile':
    command => "/usr/sbin/auth-client-config -p ${profile} -t nss -r",
    refreshonly => true,
  }
}
