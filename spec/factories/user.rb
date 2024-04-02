FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }

    after(:create) do |user, evaluator|
      WalletType::WALLET_TYPES.each do |type_name|
        # Encuentra o crea el WalletType necesario.
        wallet_type = WalletType.find_or_create_by(name_type: type_name)
        # Crea las Wallets asociadas al User y al WalletType correspondiente.
        user.wallets.create!(wallet_type: wallet_type, amount: 0.0)
      end
    end
  end
end