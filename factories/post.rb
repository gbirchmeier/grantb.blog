FactoryGirl.define do
  factory :post do
	sequence(:headline) {|n| "Dumb headline {n}"}
	sequence(:content) {|n| "Dumb content {n}"}
        user
        published_at Time.zone.now
  end
end

