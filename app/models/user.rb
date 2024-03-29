class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :parent, class_name: 'User', optional: true
  has_many :children, class_name: 'User', foreign_key: 'parent_id'
  has_many :investments
  has_many :wallets
  has_many :profits, through: :investments
  has_many :rewards, dependent: :destroy
  has_many :referred_rewards, class_name: 'Reward', foreign_key: 'referring_user_id', dependent: :destroy


  after_create :assign_default_role
  before_create :generate_user_code
  after_create :create_wallets

  def wallet_by_type(type_name)
    wallets.joins(:wallet_type).find_by(wallet_types: { name_type: type_name })
  end

  def all_descendants
    children.each_with_object(children.to_a) do |child, descendants|
      descendants.concat(child.all_descendants)
    end
  end

  def all_ancestors(ancestors = [])
    return ancestors unless parent

    ancestors << parent
    parent.all_ancestors(ancestors)
  end

  private

  def create_wallets
    return false if wallets.present?
    ActiveRecord::Base.transaction do
      WalletType::WALLET_TYPES.each do |type|
        wallet_type = WalletType.find_by(name_type: type)
        Wallet.create!(user_id: self.id, wallet_type_id: wallet_type.id)
      end
    end
  end

  def generate_user_code
    loop do
      self.user_code = SecureRandom.hex(10)
      break unless User.exists?(user_code: user_code)
    end
  end

  def assign_default_role
    self.add_role(:investor) if self.roles.blank?
  end
end
