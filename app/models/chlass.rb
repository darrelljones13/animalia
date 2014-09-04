class AnimalClass < ActiveRecord::Base
  belongs_to :phylum
  has_many :chlasses
  has_many :families, through: :order
end
