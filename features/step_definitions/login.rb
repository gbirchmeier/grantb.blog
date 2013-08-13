Given /^I am not logged in$/ do
  visit "/"
  step("I should see that no one is logged in")
end

Given /^I (?:log ?in|am logged in) as "([^"]*)" with "([^"]*)"$/ do |username, pw|
  if username.empty? and pw.empty?
    step("I am not logged in")
  else
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
  assert has_css?("#userbox"), "Expected to see #userbox"
end

Then /^I should see that no one is logged in$/ do
  assert has_no_css?("#userbox"), "Expected to not see #userbox"
end

Then /^I should see a logout notice$/ do
  assert has_content?("You are logged out")
end
