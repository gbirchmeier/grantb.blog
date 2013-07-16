When /^I visit "\/?([^"]*)"\s*$/ do |uri|
  visit "/#{uri}"
end

When /^I visit the logon page$/ do
  visit "/wutang"
end


