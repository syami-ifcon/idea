require 'rails_helper'
# require 'capybara/rspec'

y = User.create(name: "abc", password: '123')

RSpec.describe List, :type => :model do
  
  it "title and content should be present" do
  	x = List.create(title: nil,content: nil)
  	expect{x.valid? == false}
  end

  it "title and content should if not fill" do
    x = List.create(title: 'nil',content: 'nil',user_id: y.id)
    expect{x.valid? == true}
  end

  it "could not create without a user" do
  	x = List.create(title: "nil",content: "nil")
  	expect{x.valid? == false}
  end

  it 'succes create with user and full title and content input' do
  	x = List.create(title: "nil",content: "nil",user_id: y.id)
  	expect{x.valid? == true}
  end

end

RSpec.describe User, :type => :model do
  it "could not sign up with the same name" do
  	x = User.create(name: "abc", password: '123')
  	expect{x.valid? == false}
  end

  it "could not sign up with the without password" do
    x = User.create(name: "abc", password: nil)
    expect{x.valid? == false}
  end

  it "can sign up succesfully" do
    x = User.create(name: "hahaha", password: 'nil')
    expect{x.valid? == true}
  end

  it "name and password should be fill" do
  	x = User.create(name: nil, password: nil)
  	expect{x.valid? == false}
  end

  context 'assosiation' do
  	it { is_expected.to have_many(:lists).dependent(:destroy)}
  end
end	

# just make on and validate it
RSpec.feature "Sign In correctly", :type => :feature do
	scenario "and fill all the input need" do
		visit sign_in_path
	    fill_in "name", :with => 'abc'
	    fill_in "password", :with => '123'
	    click_button 'Login'
		expect(page).to have_current_path(root_path)
  	end
end