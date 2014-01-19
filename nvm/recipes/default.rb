#
# Cookbook Name:: nvm
# Recipe:: default
#
# Copyright 2013 @pxp_ss
#
# All rights reserved - Do Not Redistribute
#

git "/usr/local/src/nvm" do
  repository "git://github.com/creationix/nvm.git"
  reference "master"
  action :sync
end

bash "nvm.sh" do
  code <<-EOH
    /usr/local/src/nvm/nvm.sh
    nvm install v0.10.1
    nvm default v0.10.1
  EOH
  action :nothing
end

template "/etc/profile.d/nvm.sh" do
  source "nvm.sh.erb"
  mode 0755
end

log "nvm install dane."
