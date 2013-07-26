def generate_email_address
  @generated_email_counter ||= -1
  @generated_email_counter += 1
  return "unspecified_#{@generated_email_counter}@example.com"
end

def get_user name
  u = User.find_by_username(name)
  raise "can't find user '#{name}'" unless u
  u
end

Given /^the following users:$/ do |things|
  ActiveRecord::Base.record_timestamps = true #in case somehow left in false state
  things.hashes.each {|row|
    h = Hash.new
    h[:username] = row["username"]
    h[:password] = row["password"]
    h[:password_confirmation] = row["password"]

    h[:email] = row.has_key?("email") ? row["email"] : generate_email_address()


    u = User.create(h)
    u.save!
  }
end

Given /^the following posts:$/ do |things|
  ActiveRecord::Base.record_timestamps = true #in case somehow left in false state
  things.hashes.each {|row|
    h = Hash.new

    h[:user] = get_user(row["author"])
    h[:headline] = row["headline"]
    h[:content] = row["content"]
    h[:published_at] = row["published_at"] if row["published_at"]
    h[:created_at] = row["created_at"] if row["created_at"]
    h[:updated_at] = row["updated_at"] if row["updated_at"]

    ActiveRecord::Base.record_timestamps = true
    ActiveRecord::Base.record_timestamps = false if h[:created_at] or h[:updated_at]

    p = Post.create(h)
    p.save!

    ActiveRecord::Base.record_timestamps = true
  }
end
