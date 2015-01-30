Ohai.plugin(:Apache) do
	provides "apache/modules"

	collect_data(:default) do
		apache Mash.new
		apache[:modules] = {:static => [], :shared => []}
		modules = shell_out("apachectl -t -D DUMP_MODULES")
		modules.stdout.each_line do |line|
			matches = /\s*(\w*)_module\s*\((\w*)\)\s*/.match(line)
			if !matches.nil?
				apache_module = matches.captures[0]
				dso_type = matches.captures[1]
				if dso_type == 'shared'
					apache[:modules][:shared] << apache_mod
				elsif dos_type == 'static'
					apache[:modules][:static] << apache_mod
				end
			end
		end
	end
end
