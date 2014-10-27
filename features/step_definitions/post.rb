Then /^I should be at the show page for post "([^"]*)"/ do |headline|
  post = Post.find_by!(headline: headline)
  assert_equal "/admin/posts/#{post.id}",current_path
end

Then(/^I should be at the posts admin-index page/) do
  assert_equal "/admin/posts", current_path
end

Then /^I should see the following posts:/ do |expected_table|
  table = nil
  begin
    sleeping(0.1).seconds.between_tries.failing_after(10).tries do
      rows = find("table#posts_tbl").all('tr')
      table = rows.map{|r|
        r.all('th,td').map {|c|
          #String.strip doesn't affect unicode spaces, so need to do it explicity
          #http://www.ruby-forum.com/topic/4410833
          c.text.sub(/^[[:space:]]+/, '').sub(/[[:space:]]+$/, '')
        }
      }
      expected_table.dup.diff! table
    end
  rescue Exception => e
    expected_table.dup.diff! table
  end
end


def where_published_at(h)
  return nil unless h.include?("published_at")
  val = h["published_at"]
  return "published_at IS NULL" if val.nil? or val.empty?
  return "published_at IS NOT NULL" if ["non-null","non-nil"].include?(val.downcase)
  raise "unexpected arg for 'published_at' in test table"
end

def dump_posts
  Post.all.collect{|x| x.inspect}.join("\n")
end

def dump_post_tags
  Post.all.collect{|x| "#{x.id} #{x.headline} #{x.tags_as_string}"}.join("\n")
end

Then /^dump posts/ do
  puts dump_posts
  puts dump_post_tags
end

Then /^the DB should have (?:this post|these posts):$/ do |expected_table|
  hashes = expected_table.hashes
  hashes.each{|h|
    target = {}
    target[:headline] = h["headline"] if h["headline"]
    target[:content] = h["content"] if h["content"]
    if h["user"]
      target[:user] = User.find_by!(username: h["user"])
      raise "no user '#{h[:user]}'" unless target[:user]
    end
    where_published_at = where_published_at(h)

    result = Post.where(target).where(where_published_at)
    assert result.present?, "Couldn't find #{h.inspect} \n#{dump_posts}"

    assert_equal(h[:tags], result.first.tags_as_string,"Tags comparison failed\n#{dump_post_tags}") if h[:tags]
  }
end

Then /^the DB should not have post "([^"]*)"/ do |headline|
  assert !Post.exists?(headline: headline)
end

When(/^I visit an id\-based url for post "(.*?)"$/) do |headline|
  p = Post.find_by!(headline: headline)
  visit "/posts/#{p.id}"
end

When /^I admin-show post "([^"]*)"/ do |headline|
  p = Post.find_by!(headline: headline)
  visit "/admin/posts/#{p.id}"
end

When /^I visit the delete page for post "([^"]*)"/ do |headline|
  p = Post.find_by!(headline: headline)
  visit "/admin/posts/#{p.id}/delete"
end

When /^I edit post "([^"]*)"/ do |headline|
  p = Post.find_by!(headline: headline)
  visit "/admin/posts/#{p.id}/edit"
end

Then /^I should see the invalid-post message/ do
  page.find("#invalid_post")
end

Then(/^I should see a link to admin\-show post "(.*?)"$/) do |headline|
  post = Post.find_by!(headline: headline)
  url = "/admin/posts/#{post.id}"
  #find("a", :href=>url)
  find(:xpath, "//a[@href='#{url}']")
end

Then(/^I should see a link to edit post "(.*?)"$/) do |headline|
  post = Post.find_by!(headline: headline)
  url = "/admin/posts/#{post.id}/edit"
  find(:xpath, "//a[@href='#{url}']")
end

Given(/^this test deletes all posts/) do
  Post.delete_all
end

Given(/^I should see no posts table/) do
  assert_no_selector("#posts_tbl")
end

