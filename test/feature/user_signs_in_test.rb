require 'test_helper'

feature "User signs in" do
  
  scenario "registered user signs in successfully" do
  	User.create(email:'robert@westeros.com',password:'doesntmatterjustneedstobelong')
  	visit root_path
  	click_link "Sign in"
  	fill_in 'user[email]',    with: 'robert@westeros.com'
    fill_in 'user[password]', with: 'doesntmatterjustneedstobelong'
    click_button "Sign in"
    page.must_have_content("Signed in successfully")
  end

end
