class apt {
  $apt_sources_list = "/etc/apt/sources.list.d/puppet.list"
  $apt_templ_source = "apt/base-repos.erb"
  include apt::config
}

class apt::launchpad_repo ($repo_name, $apt_url, $apt_keyserver, $apt_signing_key) {
  $apt_sources_list = "/etc/apt/sources.list.d/${repo_name}.list"
  $apt_templ_source = "apt/sources-list-launchpad.erb"
  include apt::config
  
  exec { "import-key":
    command     => "/usr/bin/gpg --ignore-time-conflict --no-options --no-default-keyring --secret-keyring /etc/apt/secring.gpg --trustdb-name /etc/apt/trusted.gpg --keyring /etc/apt/trusted.gpg --primary-keyring /etc/apt/trusted.gpg --keyserver ${apt_keyserver} --recv ${apt_signing_key}",
    refreshonly => true,
    subscribe   => File["sources_list"]
  }
}
