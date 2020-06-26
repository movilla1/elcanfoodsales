FactoryBot.define do
  factory :price do
    association :user
    association :price_list
    association :product
    price { 1.5 }
    status { 'active' }
  end
end
