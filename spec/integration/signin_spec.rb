require 'rails_helper'
require 'byebug'

#Describe the sign in process

describe "sign in process", type: :feature do
  before :each do

    User.create(name: "Bob", password: "1234", email: "bob@email.com")
  end

  it "signs in" do
    visit sign_in_path

      fill_in 'email', with: "bob@email.com"
      fill_in 'password', with: "1234"

    click_button 'Submit'
    expect(page).to have_content "Sign Out"
  end
end