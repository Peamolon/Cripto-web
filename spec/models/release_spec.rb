require 'rails_helper'

RSpec.describe Release, type: :model do
  context "Test relationships" do
    it { is_expected.to belong_to(:wallet) }
    it { is_expected.to belong_to(:investment) }
    it { is_expected.to belong_to(:user) }
  end
end
