class Genus < ActiveRecord::Base
  belongs_to :family
  has_many :species
end
