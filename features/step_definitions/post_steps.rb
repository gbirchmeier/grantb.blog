Then /^I should be at the show page for post "([^"]*)"/ do |headline|
  post = Post.find_by_headline(headline)
  assert current_path=="/posts/#{post.id}"
end

Then /^I should see the following draft posts:/ do |expected_table|

  #expected_table.map_column!(:multiplier, false) {|c| c.to_f}

  table = nil 
  begin
    sleeping(0.1).seconds.between_tries.failing_after(10).tries do
      rows = find("table#drafts_tbl").all('tr')
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
