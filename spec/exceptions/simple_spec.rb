require 'spec_helper'

describe Exceptions::Simple do
	describe "building a model exception" do
		before do
			@simple = { 
				message: "something went wrong",
				field: "class[attribute]"
			}
		end
		
		it "should build a model error" do
			exception = Exceptions::Simple.build(@simple).error
			expect(exception[:error]).to be_kind_of(Hash)
			expect(exception[:error]).to include(
				field: "class[attribute]",
				message: "something went wrong"
			)
		end

		it "should have a message" do
			exception = Exceptions::Simple.build(@simple)
			expect(exception).to respond_to(:message)
			expect(exception.message).to eql("something went wrong")
		end

	end


end