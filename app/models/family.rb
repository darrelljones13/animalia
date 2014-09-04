class Family < ActiveRecord::Base
  belongs_to :order
  has_many :families
  has_many :species, through: :genus
end
