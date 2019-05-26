FactoryBot.define do  
  factory :user do
    email { Faker::Internet.email }
    password { '123456' }
  end

  factory :shop do
    name { Faker::Name.unique.name }
  end

  factory :furniture_item do
  	name { Faker::Name.unique.name }
  	description { Faker::Name.unique.name }
    length { rand(1..100) }
  	width { rand(1..100) }
    kind { rand(1..5) }
  	price { rand(1000..15000) }
  	shop { create :shop }
  end
end