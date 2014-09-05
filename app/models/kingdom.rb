class Kingdom < ActiveRecord::Base
  has_many :phylums
  has_many :chlasses, through: :phylum
end
