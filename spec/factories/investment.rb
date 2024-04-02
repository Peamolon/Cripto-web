FactoryBot.define do
  factory :investment do
    association :user
    association :crypto
    association :wallet, factory: :investment_wallet
    amount { 1000.00 }
    period { 12 }
    start_date { Time.zone.today }
    end_date { 1.year.from_now }

    trait :finished do
      status { 'finished' }
    end

    trait :released do
      status { 'released' }
    end
  end
end
