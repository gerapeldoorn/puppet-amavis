class amavis::config(
  $final_virus_destiny      = 'D_DISCARD',
  $final_banned_destiny     = 'D_BOUNCE',
  $final_spam_destiny       = 'D_DISCARD',
  $final_bad_header_destiny = 'D_BOUNCE',
  $max_servers              = '2',
  $mydomain                 = 'example.com',
  $mynetworks               = [ '10.0.0.0/8', '172.16.0.0/12', '192.168.0.0/16' ],
  $whitelist                = undef,   # enable whitelisting
  $whitelist_entries,
) {

  include amavis

  $real_whitelist = join($whitelist_entries,"','")

  file { '/etc/amavisd/amavisd.conf':
    ensure  => present,
    content => template('amavis/amavisd.conf.erb'),
    notify  => Service['amavisd'],
    require => Exec['amavis'],
  }

}
