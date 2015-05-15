actions :create, :remove
default_action :create

attribute :site_name, :name_attribute => true, :kind_of => String, :required => true
attribute :site_port, :default => 80, :kind_of => Fixnum
attribute :test_arg, :required => true, :kind_of => String
