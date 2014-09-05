class Family < ActiveRecord::Base
  belongs_to :order
  has_many :genus
  has_many :species, through: :genus


  validates :name, uniqueness: true

end
