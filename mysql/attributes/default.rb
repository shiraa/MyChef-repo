# rpm files
default['mysql']['rpm'] = [
  'MySQL-server-5.6.15-1.el6.x86_64.rpm',
  'MySQL-client-5.6.15-1.el6.x86_64.rpm',
  'MySQL-devel-5.6.15-1.el6.x86_64.rpm',
  'MySQL-shared-5.6.15-1.el6.x86_64.rpm',
  'MySQL-shared-compat-5.6.15-1.el6.x86_64.rpm'
]

# my.cnf default values
# mysql
default['mysql']['listen_port']   = 3306
default['mysql']['charcter_set']  = 'utf8'
default['mysql']['data_dir']      = '/usr/local/var/mysql'
default['mysql']['socket']        = '/tmp/mysql/mysql.sock'
default['mysql']['strage_engine'] = 'InnoDB'

# innodb
default['mysql']['strage_engine'] = 'InnoDB'
default['innodb']['innodb_data_dir'] = '/usr/local/var/mysql'
