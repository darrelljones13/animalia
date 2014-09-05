class Chlass < ActiveRecord::Base
  belongs_to :phylum
  has_many :orders
  has_many :families, through: :order

  validates :name, uniqueness: true
end
