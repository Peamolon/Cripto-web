FactoryBot.define do

  factory :wallet_release do
    name { "rele" }
    user { nil }
    wallet_type { nil }
  end

  factory :wallet_investment do
    name { "rele" }
    user { nil }
    wallet_type { nil }
  end

  factory :wallet_profit do
    name { "rele" }
    user { nil }
    wallet_type { nil }
  end

  factory :reward do
    user { nil }
    bonus_type { "MyString" }
    amount { "9.99" }
    awarded_at { "2024-03-29 09:46:24" }
    investment { nil }
    referring_user_id { 1 }
  end


  factory :user_bonu do
    user { nil }
    bonus_type { "MyString" }
    amount { "9.99" }
    awarded_at { "2024-03-29 09:44:27" }
    investment { nil }
    referring_user_id { 1 }
  end


  factory :release do
    profit_amount { "9.99" }
    amount { "9.99" }
    wallet { nil }
    investment { nil }
    user { nil }
  end

  factory :profit do
    wallet
    investment
    status { "not_paid" }
    paid_date { "2024-03-28" }
    amount { rand(0..100)}
  end

  factory :transaction do
    wallet { nil }
    user { nil }
    amount { "9.99" }
    transaction_type { "MyString" }
    date { "2024-03-28 12:56:30" }
  end

  factory :wallet do
    name { "rele" }
    user { nil }
    wallet_type { nil }
  end

  factory :waller do
    name { "MyString" }
    user { nil }
  end

  factory :role do
    
  end



  factory :crypto do
    name { 'Bitcoin' }
    symbol { 'BTC' }
  end

  factory :crypto_eth, class: 'Crypto' do
    name { 'Ethereum' }
    symbol { 'ETH' }
  end

  factory :crypto_ada, class: 'Crypto' do
    name { 'Cardano' }
    symbol { 'ADA' }
  end
end