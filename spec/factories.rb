FactoryBot.define do
  factory :role do
    
  end

  factory(:user) do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
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