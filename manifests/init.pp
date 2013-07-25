################################################################
# A puppet helper module for vagrant boxes running symfony apps
# compatible with Ubuntu 12.04 and VirtualBox
# NOT INTENDED FOR PRODUCTION
#
# @author Erika Heidi
# https://github.com/vagrantee/puppet-symfony
################################################################

class symfony(
  $doc_root    = '/vagrant',
  $template    = 'symfony/parameters.yml.erb',
  $db_driver   = 'pdo_mysql',
  $db_host     = '127.0.0.1',
  $db_port     = '~',
  $db_name     = 'symfony',
  $db_user     = 'symfony',
  $db_pass     = 'symfony',
  $mailer      = 'smtp',
  $mailer_host = 'localhost',
  $mailer_user = '~',
  $mailer_pass = '~',
  $locale      = 'en',
  $secret      = 'onetwothreefourcatsinarow') {

  # change default apache user and groups
  exec { 'ApacheUserGroup':
    command => "sed -i 's/www-data/vagrant/' /etc/apache2/envvars",
    onlyif  => "grep -c 'www-data' /etc/apache2/envvars"
  }

  # change cache and log permissions
  file { '/vagrant/app/cache':
    ensure  => 'directory',
    owner   => "vagrant",
    group   => "vagrant",
    mode    => 777,
  }

  file { '/vagrant/app/logs':
    ensure  => 'directory',
    owner   => "vagrant",
    group   => "vagrant",
    mode    => 777,
  }

  file { "/var/lib/php/session" :
    owner   => "root",
    group   => "vagrant",
    mode    => 0770
  }

  #define the parameters.yml file if it doesnt exists yet
  file { "${doc_root}/app/config/parameters.yml" :
    ensure => 'file',
    owner  => 'vagrant',
    group  => 'vagrant',
    content => template($template)
  }
}