Then /^I should be at the show page for post "([^"]*)"/ do |headline|
  post = Post.find_by_headline(headline)
  assert current_path=="/posts/#{post.id}"
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

Then /^the DB should have (?:this post|these posts):$/ do |expected_table|
  hashes = expected_table.hashes
  hashes.each{|h|
    target = {}
    target[:headline] = h["headline"] if h["headline"]
    target[:content] = h["content"] if h["content"]
    if h["user"]
      target[:user] = User.find_by_username(h["user"])
      raise "no user '#{h[:user]}'" unless target[:user]
    end
    where_published_at = where_published_at(h)

    result = Post.where(target).where(where_published_at)
    refute result.empty?, "Couldn't find #{h.inspect} \n#{dump_posts}"
  }
end

Then /^the DB should not have post "([^"]*)"/ do |headline|
  assert_nil Post.find_by_headline(headline)
end

When /^I ((?:edit|visit)) post "([^"]*)"/ do |cmd,headline|
  p = Post.find_by_headline(headline)
  case cmd
    when "visit" then visit "/posts/#{p.id}"
    when "edit" then visit "/posts/#{p.id}/edit"
    else raise "invalid cmd"
  end
end

