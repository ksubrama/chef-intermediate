#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, Kartik Null Cating-Subramanian
#
# All rights reserved - Do Not Redistribute
#

package "httpd" do
  action :install
end

# Disable the default virtual host
apache_vhost "welcome" do
	action :remove
	notifies :restart, "service[httpd]"
end

# Iterate over the apache sites
search("apache_sites", "*:*").each do |site|
# Set the document root
	apache_vhost site["id"] do
		site_port site["port"]
		action :create
		notifies :restart, "service[httpd]"
	end
end

service "httpd" do
  action [ :enable, :start ]
end
