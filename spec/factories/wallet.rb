FactoryBot.define do
  factory :wallet do
    amount { 0 }
    association :user
    wallet_type

    factory :release_wallet do
      wallet_type { association(:wallet_type, :release) }
    end

    factory :investment_wallet do
      wallet_type { association(:wallet_type, :investment) }
    end

    factory :profit_wallet do
      wallet_type { association(:wallet_type, :profit) }
    end
  end
end
