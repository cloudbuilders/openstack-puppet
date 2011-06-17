# FIXME: (rp) this is a train wreck.  need to substitute out the puppet apt class
class apt {
  $apt_sources_list = "/etc/apt/sources.list.d/puppet.list"
  $apt_templ_source = "apt/base-repos.erb"
  include apt::config
}

class apt::launchpad_repo ($repo_name, $apt_url, $apt_keyserver, $apt_signing_key) {
  $apt_sources_list = "/etc/apt/sources.list.d/${repo_name}.list"
  $apt_templ_source = "apt/sources-list-launchpad.erb"

  file { "sources_list-$repo_name":
    path    => $apt_sources_list,
    ensure  => present,
    owner   => "root",
    group   => "root",
    mode    => 0640,
    content => template($apt_templ_source),
    notify  => [ Exec["import-key"], Exec["apt-update"] ],
    require => File["/etc/apt/sources.list.d"]
  }
  
  exec { "import-key":
    command     => "/usr/bin/gpg --ignore-time-conflict --no-options --no-default-keyring --secret-keyring /etc/apt/secring.gpg --trustdb-name /etc/apt/trusted.gpg --keyring /etc/apt/trusted.gpg --primary-keyring /etc/apt/trusted.gpg --keyserver ${apt_keyserver} --recv ${apt_signing_key}",
    refreshonly => true
  }
}
