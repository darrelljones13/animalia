class Family < ActiveRecord::Base
  belongs_to :order
  has_many :genus
  has_many :species, through: :genus

  validates :name, uniqueness: true

  def taxonomy
    {
    "kingdom" => self.order.chlass.phylum.kingdom.name,
    "phylum" => self.order.chlass.phylum.name,
    "class" => self.order.chlass.name,
    "order" => self.order.name
    }
  end


end
