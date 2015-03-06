# represents the simple errors
module Exceptions
	class UnauthorizedApplication < Base
		attr_accessor :status

	
		# for standard errors this method build a hash
		# @return [String] json string
		def error
			{ 
				error: { 
					message: self.object[:message],
				} 
			}
		end

		# return the error message
		# @return [String]
		def message
			self.object[:message]
		end

		# return the error status
		def status
			:unauthorized
		end

	end
end