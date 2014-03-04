# == Class: dhcpd
#
# isc-dhcpd installed and configured for Razor.
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
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'dhcpd':
#    network => '10.127.1.0',
#    netmask => '255.255.255.0',
#    ntp     => '10.127.1.10',
#    range   => '10.127.1.100 10.127.1.200',
#    router  => '10.127.1.1',
#    dns     => '10.127.1.11',
#  }
#
# === Authors
#
# Author Name <greent@vmware.com>
#
# === Copyright
#
# Copyright 2014 VMware, Inc., unless otherwise noted.
#
class dhcpd (
  $network = undef,
  $netmask = undef,
  $ntp = undef,
  $range = undef,
  $router = undef,
  $dns = undef,
  $domain = undef,
)
{

  package { 'dhcp-server': ensure => installed }

  service { 'isc-dhcp-server':
    ensure  => 'running',
    enable => 'true',
  }

  file { '/etc/dhcp/dhcpd.conf':
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    content => template('dhcpd/dhcpd.conf.erb'),
    notify  => Service['isc-dhcp-server']
  }

  Package['dhcp-server'] -> File['/etc/dhcp/dhcpd.conf'] -> Service['isc-dhcp-server']

}
