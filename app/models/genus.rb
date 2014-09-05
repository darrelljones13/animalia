class Genus < ActiveRecord::Base
  belongs_to :family
  has_many :species

  validates :name, uniqueness: true

end
