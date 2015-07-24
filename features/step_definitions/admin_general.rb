def invalid_item_id(type)
  klass = type.capitalize.constantize
  highest_id = klass.all.order(id: :desc).first.try(:id)
  highest_id.to_i + 1 
end

When /^I visit an invalid admin-show ([A-Za-z-_]+) url$/ do |type|
  id = invalid_item_id(type)
  visit "/admin/#{type.downcase.pluralize}/#{id}"
end

When /^I visit an invalid edit ([A-Za-z-_]+) url$/ do |type|
  id = invalid_item_id(type)
  visit "/admin/#{type.downcase.pluralize}/#{id}/edit"
end

Then /^I should see the admin-invalid-item message$/ do
  page.find("#admin_invalid_item")
end

