When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field,input|
  fill_in field, :with => input
end

# For checking presence/non-presences of form fields
#   Then I should see a field for "username"
#   Then I should not see a field for "username"
Then /^I should( not)? see a field for "([^"]*)"$/ do |negative,label|
  if negative
    page.should_not have_field(label)
  else
    page.should have_field(label)
  end 
end

Then /^"([^"]*)" should be (not |un)?checked$/ do |arg1,negated|
  field = find_field(arg1)
  if negated
    refute field.checked?
  else
    assert field.checked?
  end
end

When /^I check "([^"]*)"$/ do |page_el|
  check(page_el)
end

When /^I uncheck "([^"]*)"$/ do |page_el|
  uncheck(page_el)
end

Then(/^I should see that field "(.*?)" contains "(.*?)"$/) do |label,expected|
  assert_equal expected, find_field(label).value
end
