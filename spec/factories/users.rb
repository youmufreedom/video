FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    reset_password_token { Faker::Alphanumeric.alphanumeric(number: 10) }
    reset_password_sent_at { Faker::Time.backward(days: 1) }
    remember_created_at { Faker::Time.backward(days: 7) }
    created_at { Faker::Time.between(from: 2.years.ago, to: Time.current) }
    updated_at { Faker::Time.between(from: 2.years.ago, to: Time.current) }
    organisation_id { FactoryBot.create(:organisation).id }
  end
end
