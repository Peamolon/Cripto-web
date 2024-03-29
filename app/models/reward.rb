class Reward < ApplicationRecord
  belongs_to :user
  belongs_to :investment

  belongs_to :referring_user, class_name: 'User', optional: true

  INVESTMENT = 'Investment'.freeze
  PERFORMANCE = 'Performance'.freeze

  REWARD_TYPES = %w[
    Investment
    Performance
  ].freeze
  public_constant :REWARD_TYPES

end
