require 'rubygems'
require 'pony'

module My
	class Email < Chef::Handler
		def initialize(from_address, to_address)
			@from_address = from_address
			@to_address = to_address
		end

		def report
			status = "Failed"
			if success?
				status = "Successful"
			end
			subject = "#{status} Chef run report from #{node.name}"
			report_string = ""

			if ! run_status.updated_resources.empty?
				run_status.updated_resources.each do |r|
					report_string += "The resource #{r.name} was changed in cookbook #{r.cookbook_name} at #{r.source_line}\n"
				end
			else
				report_string += "No resources changed by chef-client\n"
			end

			Pony.mail(
				:to => @to_address,
				:from => @from_address,
				:subject => subject,
				:body => report_string)
		end
	end
end
