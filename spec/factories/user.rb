FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "123456" }

    before(:create) do |_user, _evaluator|
      WalletType::WALLET_TYPES.each do |type_name|
        unless WalletType.exists?(name_type: type_name)
          create(:wallet_type, name_type: type_name)
        end
      end
    end
    after(:create) do |user, evaluator|
      WalletType::WALLET_TYPES.each do |type|
        wallet_type = WalletType.find_by(name_type: type)
        if wallet_type
          user.wallets.create!(wallet_type: wallet_type)
        else
          raise "WalletType '#{type}' not found."
        end
      end
    end
  end
end
