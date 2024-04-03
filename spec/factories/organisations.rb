FactoryBot.define do
  factory :organisation do
    name { "My Organisation" }
    description { "This is my organisation" }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
