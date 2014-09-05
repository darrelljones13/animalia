class Species < ActiveRecord::Base
  belongs_to :genus

  validates :scientific_name, uniqueness: true

end
