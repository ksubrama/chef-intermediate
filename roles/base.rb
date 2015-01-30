name "base"
description "Base Server Role"
run_list "recipe[email_handler]", "recipe[chef-client::delete_validation]", "recipe[chef-client::config]", "recipe[chef-client]", "recipe[ntp]", "recipe[motd]", "recipe[users]"
default_attributes({
	"chef_client" => {
		"config" => {
			"ssl_verify_mode" => ":verify_peer",
			"log_level" => ":info"
		}
	},
	"ohai" => {
		"disabled_plugins" => [":Passwd"]
	}
})
