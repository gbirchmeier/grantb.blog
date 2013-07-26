Given /^I am not logged in$/ do
puts "-- NOT LOGGED IN"
  visit "/"
  step("I should see that no one is logged in")
end

Given /^I (?:log ?in|am logged in) as "([^"]*)" with "([^"]*)"$/ do |username, pw|
  if username.empty? and pw.empty?
    step("I am not logged in")
  else
puts "-- #{username}"
    visit "/logout"
    visit "/wutang"
    fill_in "Username", :with => username
    fill_in "Password", :with => pw
    click_button("Submit")
  end
end

# When I logout
# When I log out
When /^I log ?out/ do
  visit '/logout'
end

Then /^I should see that I am logged in$/ do
  assert has_css?(".userbox")
  assert has_content?("You are logged in")
end

Then /^I should see that no one is logged in$/ do
  assert has_no_css?(".userbox"), "Expected to not see a userboxs"
  assert has_no_content?("logged in")
end

Then /^I should see a logout notice$/ do
  assert has_content?("You are logged out")
end
