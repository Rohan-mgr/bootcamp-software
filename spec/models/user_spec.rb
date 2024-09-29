require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it "should have email" do
    expect(user.email).to eq("rohan.magar@fleetpanda.com")
  end

  it "should be invalid without email" do
    user.email = nil
    expect(user).not_to be_valid
  end

  it "with name, email, password, organizationId and roles" do
    expect(user).to be_valid
  end

  it "must have token" do
    token = user.generate_jwt

    expect(token).not_to be nil
  end

  #  describe "#User Token" do  #creating sub module for user model testing
  #   it "should have token" do
  #     expect(true).to be true
  #   end
  # end
end
