FactoryBot.define do
  factory :wallet_type do
    initialize_with { WalletType.find_or_create_by(name_type: name_type) }

    trait :investment do
      name_type { WalletType::INVESTMENT }
    end

    trait :profit do
      name_type { WalletType::PROFIT }
    end

    trait :release do
      name_type { WalletType::RELEASE }
    end
  end
end
