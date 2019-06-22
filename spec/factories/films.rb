FactoryBot.define do
  factory :film do
    local { "ru" }
    sequence(:title) { |n| "My awesome film #{n}" }
    date { Time.now.to_date }
    rating { 10 }
    sequence(:description) { |n| "The description of my awesome film#{n}" }
    avatar { { url: "123.jpg" } }
  end
end
