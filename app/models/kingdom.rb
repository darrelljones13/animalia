class Kingdom < ActiveRecord::Base
  has_many :phylums
  has_many :chlasses, through: :phylum

  validates :name, uniqueness: true

  def taxonomy
    {
    }
  end
end
