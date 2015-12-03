class Exceptions::Resource < Exceptions::Base
	# for standard errors this method build a hash
	# @return [String] json string
	def error
		{
			error: { 
				model: self.object["model"],
				attribute: self.object["attribute"],
				field: self.object["field"],
				message: self.object["message"],
				full_message: "#{self.object["full_message"]}"
			} 
		}
	end

	# return the error message
	# @return [String]
	def message
		self.error[:message]
	end

	# return the error status
	def status
		406
	end
end