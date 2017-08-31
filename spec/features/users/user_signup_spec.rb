require "rails_helper"

RSpec.feature "User signup", :type => :feature do
  scenario "User signs up to the forum" do
    skip("until db is setup")
    visit root_path
    click_on('Sign Up')
    fill_in "Username", :with => "Emily Brown"
    fill_in "Email", :with => "emilybrown@test.com"
    fill_in "Date of birth", :with => "01/01/1990"
    fill_in "Password", :with => "password123"
    fill_in "Password confirmation", :with => "password123"
    click_button "Create account"

    expect(page).to have_text("Widget was successfully created.")
  end
end
