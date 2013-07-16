When /^I fill in "[^"]*" with "[^"]*"$/ do |field,input|
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

