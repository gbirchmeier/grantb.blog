Then /^I should see the following items:/ do |expected_table|
  table = nil 
  begin
    sleeping(0.1).seconds.between_tries.failing_after(10).tries do
      rows = find("table#items_tbl").all('tr')
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
