class User < ActiveRecord::Base
  has_many :cards
  has_many :collections, through: :cards
  has_many :species, through: :cards

  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /.*@.*\..*/}

  has_secure_password

end
