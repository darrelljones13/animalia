class Order < ActiveRecord::Base
  belongs_to :animal_class
  has_many :families
  has_many :genuses, through: :family
end
