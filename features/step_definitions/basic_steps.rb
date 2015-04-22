When /^I visit "\/?([^"]*)"\s*$/ do |uri|
  if uri.include?("FIRST")
    # changes e.g. "/admin/posts/FIRST/edit" to "/admin/posts/6/edit"
    model_name = uri.match(/([a-z_]+s)\/FIRST/)[1].capitalize.chop
    id = model_name.constantize.first.id #reflection magic here
    uri.sub!("FIRST",id.to_s)
  end
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

Then /^I should see "([^"]*)" is in italics$/ do |text|
  find("em",text:text)
end

# for sleazy debugging
Then /^what$/ do
  puts
  puts "==================================================="
#Post.all.each{|p|
#  puts "#{p.inspect}"
#}
  puts current_path
  puts page.source
  puts "==================================================="
end

