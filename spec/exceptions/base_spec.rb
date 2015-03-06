require 'spec_helper'

describe Exceptions::Base do
	describe "building an error exception" do
		before do
			@user = User.new
			@user.errors.add(:name, "can't be blank")

		end

		it "should respond to build" do
			expect(Exceptions::Base).to respond_to(:build)
		end

		it "shouls check if is a model error"	do
			expect(Exceptions::Model.build(@user).model?).to be(true)
		end
	end
end