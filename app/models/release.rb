class Release < ApplicationRecord
  belongs_to :wallet
  belongs_to :investment
  belongs_to :user
end
