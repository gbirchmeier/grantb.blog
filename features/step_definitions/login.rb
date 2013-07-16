Given /^I log ?in as "([^"]*)" with "([^"]*)"$/ do |username, pw|
  visit "/logout"
  visit "/wutang"
  fill_in "Username", :with => username
  fill_in "Password", :with => pw
  click_button("Submit")
end

# When I logout
# When I log out
When /^I log ?out/ do
  visit '/logout'
end
