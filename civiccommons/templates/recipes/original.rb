#
# Cookbook Name:: civiccommons
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "deploy"

node[:deploy].each do |application, deploy|
  deploy = node[:deploy][application]
  
  template "#{deploy[:deploy_to]}/shared/config/civic_commons.yml" do
    source "civic_commons.yml.erb"
    cookbook 'civiccommons'

    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    
    only_if do
      File.exists?("#{deploy[:deploy_to]}") && File.exists?("#{deploy[:deploy_to]}/shared/config/")
    end
  end
end
