Then /^I should see the not-allowed page$/ do
  assert_equal not_allowed_path, current_path
  assert has_css?('#not_cool',:text=>"No.")
end

Then /^I should see a creation notice$/ do
  assert has_content?("was successfully created")
end

Then /^I should see an update notice$/ do
  assert has_content?("was successfully updated")
end

