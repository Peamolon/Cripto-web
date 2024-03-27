class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :parent, class_name: 'User', optional: true
  has_many :children, class_name: 'User', foreign_key: 'parent_id'

  has_many :investments
  after_create :assign_default_role
  before_create :generate_user_code

  def all_descendants
    children.each_with_object(children.to_a) do |child, descendants|
      descendants.concat(child.all_descendants)
    end
  end

  private

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
