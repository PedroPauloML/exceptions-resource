require 'spec_helper'

describe Exceptions::UserTypeNotFound do
	describe "building a model exception" do
		before do
			@exception = Exceptions::UserTypeNotFound.new
		end
		
		it "should build a error" do
			expect(@exception.error).to be_kind_of(Hash)
			expect(@exception.error[:error]).to include(
				message: "Este tipo de usuário não existe, os tipos aceitos são: market, store e client",
				field: "type"				
			)
		end

		it "should have a message" do
			expect(@exception).to respond_to(:message)
			expect(@exception.message).to eql("Este tipo de usuário não existe, os tipos aceitos são: market, store e client")
		end

	end


end