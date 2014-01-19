#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2013, pxp_ss
#
# All rights reserved - Do Not Redistribute
#

directory "/usr/local/var" do
  user 'root'
  group 'root'
  recursive true
  mode 00777
  action :create
  not_if { ::File.exists?("/usr/local/var/*")}
end

package 'mysql-libs' do
  action :remove
end

node['mysql']['rpm'].each do |rpm|
  cookbook_file "/tmp/#{rpm}" do
    action :create
    source "#{rpm}"
  end

  rpm_package "#{rpm}" do
    action :install
    source "/tmp/#{rpm}"
  end
end

class Chef::Resource::Template
  include MysqldParam
end

class Chef::Resource::Template
  include InnodbParam
end

template '/etc/my.cnf' do
  source 'my.cnf.erb'
  owner 'root'
  group 'root'
  mode 644

  mysql_params = Hash::new
  get_mysql_params(mysql_params)

  innodb_params = Hash::new
  get_innodb_params(innodb_params)

  variables({
    :listen_port => node['mysql']['listen_port'],
    :charcter_set => node['mysql']['charcter_set'],
    :data_dir => node['mysql']['data_dir'],
    :socket => node['mysql']['socket'],
    :strage_engine => node['mysql']['strage_engine'],
    :innodb_data_dir => node['innodb']['innodb_data_dir'],
    :mysql_params => mysql_params,
    :innodb_params => innodb_params
  })
end

execute "move" do
  command "mv /var/lib/mysql /usr/local/var/"
  only_if { ::File.exists?("/var/lib/mysql")}
end

service 'mysql' do
  action [:start, :enable]
end
