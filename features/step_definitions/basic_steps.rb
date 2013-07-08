When /^I visit "?\/?([^"]*)"?\s*$/ do |uri|
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
Then /^I should( not)? see "([^"]*)"\s*$/ do |negative, text|
  if negative then
    page.should_not have_xpath(".//*[text()='#{text}']", :visible => true)
  else
    page.should have_content(text)
  end 
end

# for sleazy debugging
Then /^what$/ do
  puts
  puts "==================================================="
  puts page.source
  puts "==================================================="
end

