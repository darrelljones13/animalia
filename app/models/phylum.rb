class Phylum < ActiveRecord::Base
  belongs_to :kingdom
  has_many :chlasses
  has_many :orders, through: :chlass

  validates :name, uniqueness: true

end
