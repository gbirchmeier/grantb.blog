def generate_email_address
  @generated_email_counter ||= -1
  @generated_email_counter += 1
  return "unspecified_#{@generated_email_counter}@example.com"
end

Given /^the following users:$/ do |things|
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

