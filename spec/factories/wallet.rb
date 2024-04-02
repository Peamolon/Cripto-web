FactoryBot.define do
  factory :wallet do
    amount { 0 }
    association :user
    association :wallet_type
  end

  factory :release_wallet, parent: :wallet do
    after(:build) do |wallet|
      wallet.wallet_type = FactoryBot.create(:wallet_type, :release) unless wallet.wallet_type
    end
  end

  factory :investment_wallet, parent: :wallet do
    after(:build) do |wallet|
      wallet.wallet_type = FactoryBot.create(:wallet_type, :investment) unless wallet.wallet_type
    end
  end

  factory :profit_wallet, parent: :wallet do
    after(:build) do |wallet|
      wallet.wallet_type = FactoryBot.create(:wallet_type, :profit) unless wallet.wallet_type
    end
  end
end
