require 'rails_helper'

RSpec.describe Task, type: :model do
	
#Tests on validations
  it "should have title" do

  	task = Task.new(title: nil, description: "This is not fun for all")
  	expect(task).to_not be_valid
  end

  #Tests on associations

  it "should belong to a user" do

  	t = Task.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
	end

  #Custom model method test

	it "should be done" do

		task = Task.create(title: "write tests", description: "for task model")
		task.done
		expect(task.status).to eq(true)
  end
end

