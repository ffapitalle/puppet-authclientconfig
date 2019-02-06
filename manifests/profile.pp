# Defines a pam and NSS profile
#
# @summary Defines and enable or disable a pam and NSS profile
#
# @example
#   authclientconfig::profile { 'profile_name': 
#     source => "puppet:///my_module/example_profile",
#   }
define authclientconfig::profile (
  String $profile     = $name,
  String $profile_dir = '/etc/auth-client-config/profile.d/',
  String $source      = undef,
  Boolean $enabled    = true,
) {

  unless $source {
    fail("Source not defined for ${name} ${profile}")
  }

  contain authclientconfig

  $action = bool2str($enabled, 'enable', 'disable')

  file { "profile_${profile}":
    path   => "${profile_dir}/${profile}-acc-profile",
    source => $source,
    notify => Exec["${action}_profile"],
  }

  if $enabled {
    exec { 'enable_profile':
      command => "/usr/sbin/auth-client-config -p ${profile} -t nss",
      require => File["profile_${profile}"],
      unless  => "/usr/sbin/auth-client-config -p ${profile} -t nss -s",
    }
  } else {
    exec { 'disable_profile':
      command => "/usr/sbin/auth-client-config -p ${profile} -t nss -r",
      require => File["profile_${profile}"],
      onlyif  => "/usr/sbin/auth-client-config -p ${profile} -t nss -s",
    }
  }
}
