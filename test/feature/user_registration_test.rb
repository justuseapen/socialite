require 'test_helper'

feature "New user sign up" do

  scenario "unauthenticated user registers successfully" do
    visit root_path
    page.must_have_content("sign up")
    page.must_have_content("sign in")
    fill_in 'user[email]',    with: 'robert@westeros.gov'
    fill_in 'user[password]', with: 'baratheon'
    click_button 'Next'
    page.must_have_content("You have signed up successfully")
  end

  scenario "unauthenticated user tries to sign up with bad email" do
  	visit root_path
    page.must_have_content("sign up")
    page.must_have_content("sign in")
    fill_in 'user[email]',    with: 'robert@westeros'
    fill_in 'user[password]', with: 'baratheon'
    click_button 'Next'
    page.must_have_content("Email is invalid")
  end

  scenario "unauthenticated user tries to sign up with no password" do
  	visit root_path
    page.must_have_content("sign up")
    page.must_have_content("sign in")
    fill_in 'user[email]',    with: 'robert@westeros.com'
    fill_in 'user[password]', with: ''
    click_button 'Next'
    page.must_have_content("assword can't be blank")
  end

  scenario "unauthenticated user tries to sign up with a not-unique email" do  	
  	User.create(email:'robert@westeros.com',password:'doesntmatterjustneedstobelong')
  	visit root_path
    page.must_have_content("sign up")
    page.must_have_content("sign in")
    fill_in 'user[email]',    with: 'robert@westeros.com'
    fill_in 'user[password]', with: 'baratheon'
    click_button 'Next'
    page.must_have_content("Email has already been taken")
  end

end
