Then(/^I should see a link to admin\-show user "([^"]+)"$/) do |username|
  user = User.find_by!(username: username)
  url = "/admin/users/#{user.id}"
  find(:xpath, "//a[@href='#{url}']")
end

Then(/^I should see a link to edit user "([^"]+)"$/) do |username|
  user = User.find_by!(username: username)
  url = "/admin/users/#{user.id}/edit"
  find(:xpath, "//a[@href='#{url}']")
end

When(/^I admin\-show user "([^"]+)"$/) do |username|
  user = User.find_by!(username: username)
  visit "/admin/users/#{user.id}"
end
