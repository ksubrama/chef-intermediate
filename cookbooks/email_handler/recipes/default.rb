#
# Cookbook Name:: email_handler
# Recipe:: default
#
# Copyright 2015 Kartik Null Cating-Subramanian
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

chef_gem "pony"
	action :install
end

include_recipe "chef_handler"

cookbook_file "#{node['chef_handler']['handler_path']}/email_handler.rb" do
	source "handlers/email_handler.rb"
	owner "root"
	group "root"
	mode "0644"
end

chef_handler "My::Email" do
	source "#{node['chef_handler']['handler_path']}/email_handler.rb"
	arguments [
		node['email_handler']['from_address'],
		node['email_handler']['to_address']]
	action :enable
end
