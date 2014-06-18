When /^I visit "\/?([^"]*)"\s*$/ do |uri|
  visit "/#{uri}"
end

# Then I pause 4.5 seconds
# Then I sleep 4.5
# Then pause 4.5 seconds
# Then sleep 4.5
Then /^(?:I )?(?:sleep|pause) ([0-9.]+)(?: seconds)$/ do |sec|
  sleep sec.to_f
end

# very dumb; just looks for visible text
Then /^I should( not)? see "([^"]*)"$/ do |negative, text|
  if negative then
    assert has_no_content?(text)
  else
    assert has_content?(text)
  end 
end

Then /^I (?:click|press) "([^"]*)"$/ do |the_link|
  click_link_or_button(the_link)
end

Then /^I should be at the root path$/ do
  assert_equal root_path, current_path
end

Then /^I should see an element "([^"]*)"$/ do |el|
  assert has_css?(el)
end

Then /^I should not see an element "([^"]*)"$/ do |el|
  assert has_no_css?(el)
end

# for sleazy debugging
Then /^what$/ do
  puts
  puts "==================================================="
  puts page.source
  puts "==================================================="
end

