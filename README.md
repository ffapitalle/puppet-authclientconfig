
# authclientconfig

This module manages profiles, and allow to enable or disable them using auth-client-config.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with authclientconfig](#setup)
    * [What authclientconfig affects](#what-authclientconfig-affects)
    * [Beginning with authclientconfig](#beginning-with-authclientconfig)

## Description

This module should be used to apply authenticacion profiles to a linux server.

## Setup

### What authclientconfig affects

- Files in auth-client-config profiles database (by default, /etc/auth-client-config/profile.d)

### Beginning with authclientconfig

Simple example of a profile that enables authentication to an LDAP server 

## Usage

```puppet
   authclientconfig::profile { 'profile_name':
     source => "puppet:///my_module/example_profile",
   }
```

where `example_profile` contains

```
[example]
nss_passwd=passwd: files [success=return]  ldap
nss_group=group: files [success=return]  ldap
nss_shadow=shadow: compat
nss_netgroup=netgroup: nis

```
