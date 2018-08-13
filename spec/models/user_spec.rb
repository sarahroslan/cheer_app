require 'rails_helper'

RSpec.describe User, type: :model do
	
 #Tests on validations
  it "should have email" do

  	user = User.new(name: "Harry", email: nil)
  	expect(user).to_not be_valid
  end

  it "should have password" do

  	user = User.new(name: "Harry", email: "harry@email.com", password: nil)
  	expect(user).to_not be_valid
	end

	it "should have password confirmation" do
		user = User.new(name: "Harry", email: "harry@email.com", password: "12345678", password_confirmation: "")
		expect(user).to_not be_valid
	end

	it "should be valid with unique email" do

		userA = User.create(name: "Harry", email: "harry@email.com", password: "12345678", password_confirmation: "12345678")
		userB = User.new(name: "Harry", email: "harry@email.com", password: "12345678", password_confirmation: "12345678")
		expect(userB).to_not be_valid
	end

	#Testing associations

	it "should have many tasks" do

    x = User.reflect_on_association(:tasks)
    expect(x.macro).to eq(:has_many)
  end

  it "should return authencaticated user" do
  	user = User.create(name: "Harry", email: "harry@email.com", password: "12345678", password_confirmation: "12345678")
  	authencatication = Authentication.create(provider: 'google_oauth2', token: "random-token", user_id: user.id)

  expect(user.google_token).to eq("random-token")
end
end
