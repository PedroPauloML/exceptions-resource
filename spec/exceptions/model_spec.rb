require 'spec_helper'

describe Exceptions::Model do
	describe "building a model exception" do
		before do
			@user = User.new
			@user.errors.add(:name, "can't be blank")
		end

		it "should build a model error" do
			exception = Exceptions::Model.build(@user).error
			expect(exception[:error]).to be_kind_of(Hash)
			expect(exception[:error]).to include(
				model: "User",
				field: "user[name]",
				message: "can't be blank"
			)
		end

		it "should have a message" do
			exception = Exceptions::Model.build(@user)
			expect(exception).to respond_to(:message)
			expect(exception.message).to eql("can't be blank")
		end

		it "should have the model name" do
			exception = Exceptions::Model.build(@user)
			expect(exception).to respond_to(:model)
			expect(exception.model).to eql("user")
		end

	end
end