class Order < ActiveRecord::Base
  belongs_to :chlass
  has_many :families
  has_many :genus, through: :family
end
