# Class: mysql::params
#
#   The mysql configuration settings.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class mysql::params {

  $bind_address        = '127.0.0.1'
  $port                = 3306
  $server_package_name = 'mysql-server'
  $etc_root_password   = false
  $datadir             = '/var/lib/mysql'

  case $::operatingsystem {
    "Ubuntu": {
      $service_provider = upstart
    }
    default: {
      $service_provider = undef
    }
  }

  case $::osfamily {
    'RedHat': {
      $service_name          = 'mysqld'
      $client_package_name   = 'mysql'
      $socket                = '/var/lib/mysql/mysql.sock'
      $config_file           = '/etc/my.cnf'
      $ruby_package_name     = 'ruby-mysql'
      $ruby_package_provider = 'gem'
      $python_package_name   = 'MySQL-python'
    }

    'Debian': {
      $service_name         = 'mysql'
      $client_package_name  = 'mysql-client'
      $socket               = '/var/run/mysqld/mysqld.sock'
      $config_file          = '/etc/mysql/my.cnf'
      $ruby_package_name    = 'libmysql-ruby'
      $python_package_name  = 'python-mysqldb'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }

}
