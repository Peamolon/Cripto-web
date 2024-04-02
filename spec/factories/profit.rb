FactoryBot.define do
  factory :profit do
    association :wallet, factory: :profit_wallet
    association :investment, factory: :investment
    status { "not_paid" }
    paid_date { "2024-03-28" }
    amount { rand(0..100)}
  end
end

